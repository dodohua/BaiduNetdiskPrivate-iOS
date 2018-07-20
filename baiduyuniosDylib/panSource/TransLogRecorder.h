//
//     Generated by class-dump 3.5 (64 bit) (Debug version compiled Dec 14 2017 14:12:44).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2015 by Steve Nygard.
//

#import <objc/NSObject.h>

@class NSMutableString, NSString;

@interface TransLogRecorder : NSObject
{
    _Bool _isVideo;
    _Bool _isByteRange;
    _Bool _hasAddDownloadInstantaneousSpeed;
    NSMutableString *_transLog;
    NSString *_logId;
    NSString *_taskId;
    NSString *_userAgent;
    unsigned long long _fid;
    NSString *_fileName;
    unsigned long long _fileSize;
    long long _downloadType;
    unsigned long long _blockSize;
    long long _blockIndex;
    long long _blockNumAll;
    long long _blockNumThisTime;
    unsigned long long _startPosition;
    double _startTime;
    double _endTime;
    double _localTime;
    long long _transBytes;
    double _transTimes;
    long long _averageSpeed;
    unsigned long long _instantSpeedFile;
    unsigned long long _instantSpeedAll;
    long long _pcsCode;
    long long _httpCode;
    long long _otherCode;
    NSString *_clientIP;
    NSString *_serverHost;
    NSString *_requestURL;
    unsigned long long _isSuccess;
    unsigned long long _speedLimit;
    NSString *_xpcsRequestId;
    NSString *_xbsRequestId;
    unsigned long long _totalIncreaseSize;
}

@property(nonatomic) unsigned long long totalIncreaseSize; // @synthesize totalIncreaseSize=_totalIncreaseSize;
@property(nonatomic) _Bool hasAddDownloadInstantaneousSpeed; // @synthesize hasAddDownloadInstantaneousSpeed=_hasAddDownloadInstantaneousSpeed;
@property(nonatomic) _Bool isByteRange; // @synthesize isByteRange=_isByteRange;
@property(copy, nonatomic) NSString *xbsRequestId; // @synthesize xbsRequestId=_xbsRequestId;
@property(copy, nonatomic) NSString *xpcsRequestId; // @synthesize xpcsRequestId=_xpcsRequestId;
@property(nonatomic) unsigned long long speedLimit; // @synthesize speedLimit=_speedLimit;
@property(nonatomic) unsigned long long isSuccess; // @synthesize isSuccess=_isSuccess;
@property(copy, nonatomic) NSString *requestURL; // @synthesize requestURL=_requestURL;
@property(copy, nonatomic) NSString *serverHost; // @synthesize serverHost=_serverHost;
@property(copy, nonatomic) NSString *clientIP; // @synthesize clientIP=_clientIP;
@property(nonatomic) long long otherCode; // @synthesize otherCode=_otherCode;
@property(nonatomic) long long httpCode; // @synthesize httpCode=_httpCode;
@property(nonatomic) long long pcsCode; // @synthesize pcsCode=_pcsCode;
@property(nonatomic) unsigned long long instantSpeedAll; // @synthesize instantSpeedAll=_instantSpeedAll;
@property(nonatomic) unsigned long long instantSpeedFile; // @synthesize instantSpeedFile=_instantSpeedFile;
@property(nonatomic) long long averageSpeed; // @synthesize averageSpeed=_averageSpeed;
@property(nonatomic) double transTimes; // @synthesize transTimes=_transTimes;
@property(nonatomic) long long transBytes; // @synthesize transBytes=_transBytes;
@property(nonatomic) double localTime; // @synthesize localTime=_localTime;
@property(nonatomic) double endTime; // @synthesize endTime=_endTime;
@property(nonatomic) double startTime; // @synthesize startTime=_startTime;
@property(nonatomic) unsigned long long startPosition; // @synthesize startPosition=_startPosition;
@property(nonatomic) long long blockNumThisTime; // @synthesize blockNumThisTime=_blockNumThisTime;
@property(nonatomic) long long blockNumAll; // @synthesize blockNumAll=_blockNumAll;
@property(nonatomic) long long blockIndex; // @synthesize blockIndex=_blockIndex;
@property(nonatomic) unsigned long long blockSize; // @synthesize blockSize=_blockSize;
@property(nonatomic) _Bool isVideo; // @synthesize isVideo=_isVideo;
@property(nonatomic) long long downloadType; // @synthesize downloadType=_downloadType;
@property(nonatomic) unsigned long long fileSize; // @synthesize fileSize=_fileSize;
@property(copy, nonatomic) NSString *fileName; // @synthesize fileName=_fileName;
@property(nonatomic) unsigned long long fid; // @synthesize fid=_fid;
@property(retain, nonatomic) NSString *userAgent; // @synthesize userAgent=_userAgent;
@property(copy, nonatomic) NSString *taskId; // @synthesize taskId=_taskId;
@property(copy, nonatomic) NSString *logId; // @synthesize logId=_logId;
@property(retain, nonatomic) NSMutableString *transLog; // @synthesize transLog=_transLog;

- (void)logDownloadInstantaneousSpeedWithIncreaseSize:(long long)arg1 speed:(unsigned long long)arg2;
- (void)logIsByteRange:(_Bool)arg1;
- (void)logError:(id)arg1;
- (void)logXPCSRequestID:(id)arg1;
- (void)logXBSRequestID:(id)arg1;
- (void)logSpeedLimit:(unsigned long long)arg1;
- (void)logRequestURL:(id)arg1;
- (void)logServerHost:(id)arg1;
- (void)logClientIP:(id)arg1;
- (void)logOtherCode:(long long)arg1;
- (void)logHTTPCode:(long long)arg1;
- (void)logPCSCode:(long long)arg1;
- (void)logInstantSpeedFile:(unsigned long long)arg1;
- (void)logTransBytes:(long long)arg1;
- (void)logEndTime;
- (void)logStartTime;
- (void)logDelete;
- (void)logPause;
- (void)logFail;
- (void)logSuccess;
- (void)logStartPosition:(unsigned long long)arg1;
- (void)logBlockNumThisTime:(long long)arg1;
- (void)logBlockNumAll:(long long)arg1;
- (void)logBlockIndex:(long long)arg1;
- (void)logBlockSize:(unsigned long long)arg1;
- (void)logIsVideo:(_Bool)arg1;
- (void)logDownloadType:(long long)arg1;
- (void)logFileSize:(unsigned long long)arg1;
- (void)logFileName:(id)arg1;
- (void)logFid:(unsigned long long)arg1;
- (void)logTaskId:(id)arg1;
- (void)addUploadBlockLog;
- (void)addUploadFileLog;
- (void)addDownloadLog;
- (id)commonLog;
- (id)init;

@end
