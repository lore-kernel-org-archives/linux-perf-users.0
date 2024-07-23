Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2E715749C;
	Tue, 23 Jul 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755594; cv=none; b=BSstwjHV9tazE1T8bmJhKwajKDFC/OrHN7Qr6qDdWxm5isWjuVHcVuwLMDC24cKWRn7dweNNO1G14mHfd2K1KDVvZkg59Y1l7mn1V70A1zHPU8qBUgwvDPwhVAFpq4DVm0wd7CslENGDLOaEmjCZ7qv0Gv7m+xJflepVae0VOJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755594; c=relaxed/simple;
	bh=7lqeO9zi/ZPLQLjYKRu06yUs0Jen/eSzwXb6Rj/paTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVlnlv3fGl2wABkEdUekISeGF4CbkhohjBrnZ6DlfVAHAX7aNe6y5tJDryutAU2lmUbkOUiOMfN4uMn5X+RNpMXR6ky5xHpE7KN6u8tyAif9z+uEYZjFr9TU7gI7LiB159g83gr+k9aDf0xggWJ8/zs0lvDt+AC8PGCANRyZJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk8qmAvz; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk8qmAvz"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2cb6b247db0so614455a91.2;
        Tue, 23 Jul 2024 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721755592; x=1722360392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ttzMJVUPEVSPgz/kJQiGDgzHbnSKKQPBuNwmGBEWsJU=;
        b=Gk8qmAvznuoWHP/KQ3allLDwEpoltNyCbcoMDf6hDqDpe9sLsjM+7NT1ew7imawI2q
         LsLPJUQlPySGOSQzpSJHVxJsmakCeXcXZDqC/XR9Ty6eKSBn9aTwDHC5W+NDQSxtATkm
         +jvumpghNGrT0U8wnoyvvLC25uMwCwBUFTnDQ6sSNE2Zzk4kDM12TIN+D8QW0N3V7dH5
         DnGTyzzgQ0TrFG9HceNrnIBVuOHMbeA6tVUl1QB+P6yx8cMlsK6pQMzM40XAo6Yqrl/a
         TPJKK8n7QB/WjwpM597DWEBmRmll8Pi0E64lN93pSnX18eZJwGIbJYxuDWYQEqbaKVjO
         P2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721755592; x=1722360392;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttzMJVUPEVSPgz/kJQiGDgzHbnSKKQPBuNwmGBEWsJU=;
        b=hoDks0Eh0LjGRcSysKkww0EsczjztSh+enCJX5POMCHuAvbUFTJy8LRTagFlIYzRZS
         uD1ixahScJyzU7W8MFSQEWIeHyKreNxV4Bo8x2R7hMqlSt4yNgfHGJNGRr6zEPFbV3Xl
         oZY2395GbFTkccTmy2henyVLA7T61hA8GnXN+BCMBPFSVoY2FVm5PC1fSjYPWeYz7u+r
         6x6byJJXgBSgZYY6Z4Xw0VSgiNNjarwkUgibSNmDAPQtHsevmlLR2KAIT5HOr8yl8RVK
         xOid60LOHM3tl6ihPIqli49Ibrh0fmmFyntuRRMKyY20YAmgXMPvHMVXAUyEmM0gSySI
         d+nw==
X-Forwarded-Encrypted: i=1; AJvYcCWXxhS+eScB/NOOjOIPpc8g5AJ1+79RJlzmp7YFEq0B/3ICs/rSWuzYSdl72r0P5s9XgdwBlBYGh0PtQT0=@vger.kernel.org, AJvYcCX+ZtmXsFVLoBdCuKvsZXzT1VxN0hMaM4pMVcVxDUlWtpjvE0thOQpTtPdW0LbP/I0TBGewGQQWzuW0sBAJL27fng==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNHb5yhqHM2qi/5fs/8+11rVKHSNg/LiFLd4bxG4KHePkF5uoz
	XLsYvAGcSk26fQkjiQVU3vPapQ9uNFhuB1z26LQwXa78OcMPskTN
X-Google-Smtp-Source: AGHT+IFAVBRUp2zRWq3BgWOnjME8mVe5/WH6T3ywz3r6UnpX5+5S3t/eqwVhnKTuRrceVlseQdTNfA==
X-Received: by 2002:a17:902:ce83:b0:1fb:43b5:8793 with SMTP id d9443c01a7336-1fd74603b9dmr90462885ad.6.1721755591637;
        Tue, 23 Jul 2024 10:26:31 -0700 (PDT)
Received: from [192.168.123.46] (pcd463246.netvigator.com. [203.218.253.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f470686sm77553615ad.264.2024.07.23.10.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:26:31 -0700 (PDT)
Message-ID: <85253bf0-7222-4abb-a583-6c55f949e6bd@gmail.com>
Date: Wed, 24 Jul 2024 01:26:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf archive: unpack to correct dir given by perf
To: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, vmolnaro@redhat.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yuan Tan <tanyuan@tinylab.org>
References: <cover.1720372219.git.royenheart@gmail.com>
 <18fa10628f1e037753244b438b2a08b20d611135.1720372219.git.royenheart@gmail.com>
 <ZpCyf6ulH-8dRBu4@google.com>
 <f7d246d4-edae-4b4c-8b19-ad6fa66e8ea1@gmail.com>
 <alpine.LRH.2.20.2407161424070.11376@Diego>
Content-Language: en-US
From: Haoze Xie <royenheart@gmail.com>
In-Reply-To: <alpine.LRH.2.20.2407161424070.11376@Diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2024/7/16 20:29, Michael Petlan 写道:
> On Tue, 16 Jul 2024, royenheart wrote:
>> On 2024/7/12 12:35, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Mon, Jul 08, 2024 at 02:04:31AM +0800, Haoze Xie wrote:
>>>> In perf-archive.sh, the code segment that defines 'PERF_BUILDID_DIR' is
>>>> advanced before 'unpack' operation for subsequent use, followed by a
>>>> 'mkdir' operation to ensure that the dir exists. Symbols in 'unpack' will
>>>> be extracted to correct dir given by perf.
>>>>
>>>> When '--unpack' param is appointed, the symbols are extracted to '~/.debug'
>>>> folder by default, without using 'PERF_BUILDID_DIR' given by perf. This
>>>> will cause perf to be unable to find the correct buildid's path when users
>>>> configured buildid.dir in 'perf config' or used '--buildid-dir' cli param,
>>>> since perf will read these params and put them in 'PERF_BUILDID_DIR' env.
>>>> 'perf script' and 'perf report' will use the env as the basis for buildid
>>>> indexing.
>>>
>>> Can you please add an example command line and the output for the error
>>> case?  It'd be helpful to understand the problem more intuitively.
>>>
>>>>
> 
> [...]
> 
>>
>> I have two machines A and B, I use 'perf record' and 'perf archive' to get
>> a buildid archive 'perf.data.tar.bz2' on A: 
>>
>> $ perf record -a -g -- sleep 1
>> $ perf archive
>>
>> then I transfer 'perf.data' and its buildid archive to B. On machine B, I
>> use 'perf archive' to extract the buildid:
>>
>> $ perf archive --unpack
>> $   Found target file for unpacking: ./perf.data.tar.bz2
>> $   .build-id/d1/a727ab038085dbbb50e74c812e5a6e8502e8c7
>> $   ...
>>
>> But when I use 'perf script' to view hotspots, no function names are shown:
>>
>> $ perf script
>> $   No kallsyms or vmlinux with build-id 
>> $   251c1248b97a17df394058a189dffe381169ddcd was found
>> $   perf    1770 [000] 1022235.467607:          1 cycles:P: 
>> $           ffffffff8ae9ceb6 [unknown] ([kernel.kallsyms])
>> $           ffffffff8ae15af5 [unknown] ([kernel.kallsyms])
>> $           ffffffff8ae0f83b [unknown] ([kernel.kallsyms])
>> $   ......
>>
>> The problem is, I used 'perf config' to change buildid search path before:
>>
>> $ perf config --user buildid.dir=/usr/local/symbols
>> $ cat ~/.perfconfig
>> $   # this file is auto-generated.
>> $   [buildid]
>> $           dir = /usr/local/symbols
>>
> 
> Shouldn't then perf-archive just determine the directory from perf-config
> without any additional env var?
> 
>> But 'perf archive --unpack' just extract them to '~/.debug', which makes
>> perf can't found right path to search for buildid info. If I add
>> 'buildid-dir' param to replace buildid path defined in perfconfig, problem
>> can be solved temporarily:
>>
>> $ ./perf --buildid-dir ~/.debug script
>> $   perf    1770 [000] 1022235.467607:          1 cycles:P: 
>> $           ffffffff8ae9ceb6 native_write_msr+0x6 ([kernel.kallsyms])
>> $           ffffffff8ae15af5 intel_pmu_enable_all+0x15 ([kernel.kallsyms])
>> $           ffffffff8ae0f83b x86_pmu_enable+0x1ab ([kernel.kallsyms])
>>
>> The code that determines the buildid path is in the 
>> 'util/config.c:set_buildid_dir' function, which will generate
>> 'PERF_BUILDID_DIR' var.
> 
> As above, the var seems to be a duplicate to what is already stored in
> perf-config...
> 
>>
>>
> 
> Regards,
> Michael
> 

Sorry for the delay, I read about the codes, in 'perf.c:main', it will call
'perf_config' function at first, which will call 'config:set_buildid_dir'
to set an env 'PERF_BUILDID_DIR' for external commands(including
perf-archive). Codes are:

$ // perf.c
$ int main(int argc, const char **argv) {
$   // ...
$   err = perf_config(perf_default_config, NULL);
$   // ...
$ }
$
$ ...
$ // config.c
$ void set_buildid_dir(const char *dir) {
$   if (dir)
$	    scnprintf(buildid_dir, MAXPATHLEN, "%s", dir);
$
$	/* default to $HOME/.debug */
$	if (buildid_dir[0] == '\0') {
$		char *home = getenv("HOME");
$
$		if (home) {
$			snprintf(buildid_dir, MAXPATHLEN, "%s/%s",
$				 home, DEBUG_CACHE_DIR);
$		} else {
$			strncpy(buildid_dir, DEBUG_CACHE_DIR, MAXPATHLEN-1);
$		}
$		buildid_dir[MAXPATHLEN-1] = '\0';
$	}
$	/* for communicating with external commands */
$	setenv("PERF_BUILDID_DIR", buildid_dir, 1);
$ }

Or it will set to '${HOME}/.debug'('.debug' if ${HOME} not set).
'--buildid_dir' param will override it. So perf has already read the config
for us and set the 'PERF_BUILDID_DIR' env intentionally at first. I think
it's ok to use the env for indicating where to extract.
