Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7E7CF16;
	Tue, 16 Jul 2024 11:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129397; cv=none; b=tl5ZOuyjXld7Hlti2Ybtm6+LO1Ibyt1vxFmQ8J++tSfX18fBr70doEFeYsRZa0yEcp2pTn5s1r/KsytLN77mr6yqDZveGfhCnx3Sp5ALOqpopuOyPmsJZDqKiSTSkwG8zJOPPgmfGdq8SYOFReWKYgOJlzDGhHnWZjt8V3lA71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129397; c=relaxed/simple;
	bh=Ex/sVgEI2KlYErdlKBbktImpCTky6MDk2luHz2oA1Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKEJwO2RgdlKK9RLMM6ToRI1kwI4ffAOyuNj0sRZogq58WV4+E9Nt/whn/gPJyy9BVpUcWLvtOQoaizlmDm7QwYgirdjbEUbZZ41QaRF7/DHvONVcyP9DmjKRxVK9hoj6WNUbhyIybbej9cE2Xuu7r1pu/NhrJOvp9Pe74vQ68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaEvKTHG; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaEvKTHG"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fafb9df923so4592025ad.0;
        Tue, 16 Jul 2024 04:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721129395; x=1721734195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP63mf6szrpq7INTw8MI6X2MOKZr1ifzCgdLuGRzzok=;
        b=eaEvKTHGPAnnmyhy3eCnn4uhIB7NyntccyieR+ovBxvUopDgWHx7LqClMR3lck+Aei
         aYWCM+4sUKGCJxomvXFL84s65svzoznQZQdMtFs7AeQ4zOg2MEg2RpxuejCHG6r7bpkt
         FXwfSxgp0Wgj8aAYdnP0eqAXxRx/SviUvJN3Eps2DT6/Wb7ghVjxKbAbfphTfMQUk5cr
         7lWE1gospUhJct3FmLY/mjQj+pFCQEIXuu9/lft2iQ392OByIacdfnF/UqQXVJerZ0eC
         Cxbwq0InvRi66X859Us3TU9JKcUccqgLuXD4vrrnC1oiUQrOL88HUa3rjvuw9hEbUAqz
         ghyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721129395; x=1721734195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KP63mf6szrpq7INTw8MI6X2MOKZr1ifzCgdLuGRzzok=;
        b=Nh8MUMVQIDj5or7P3OrmTLlvs5qmJjZHw14iV4RP0BpQ5Qnaf3hrYlT3SQSmBfKXwY
         1fhqRElHi+1HCSGlLjy2izhalyaIvrLwKC54mlce0I1K0+Ubfs4/8d1DBxk2T1ozN0E6
         j3Ac2kjnhFafzUbnWNJ3dpSL0zcyhEu7yPC67qRidj4EEnN6FEVqSdmZFy7g6IbjKG2C
         pjg2QZAvmleo3N1n/A+n3EoFCbHs1tcHUG7qLZfoSDNwvg3OdHsxlRMlYrrh9NBNSrx2
         2Gxo21eY74OTYjnv5D1NY4YGhmw4jHo/Q5gSXmrNsBI4cerYI7SngXSR+pVgh/eSNsUW
         nsoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX01vyh6iljZNzjGTsdP48R5b1spOrhBk8UbhaQFLv5qylfj5H1snGjxW43z05gsSWmmxmATadhdfbdJq6tse/ChHaJa1AL79MlZ0kc7vXE1UPDCAgpLLUj2xvX5XzxGXW4Xi+xR2xAGeyUGiG+8A==
X-Gm-Message-State: AOJu0YzlvGDZpe/IiynWs/02g/WfBodlhTWDGEwhmObzANNinahUuOhl
	+AqCBZfSP21Q0ZoxLrJX+CGxES4RUuYYFeqPp+6Kii25Iaw2J+Zu
X-Google-Smtp-Source: AGHT+IEiWjTHBO+JrReY/Cbci7P13tsoTUK5arhbNhUWpRI6CTw3bDqkALRvVmrsaX7GPTH5fswk6Q==
X-Received: by 2002:a17:903:124f:b0:1fb:19fc:1b44 with SMTP id d9443c01a7336-1fc3bb108d5mr18295415ad.3.1721129394753;
        Tue, 16 Jul 2024 04:29:54 -0700 (PDT)
Received: from [192.168.0.6] (pcd463069.netvigator.com. [203.218.253.69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38f55sm56596255ad.222.2024.07.16.04.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 04:29:53 -0700 (PDT)
Message-ID: <f7d246d4-edae-4b4c-8b19-ad6fa66e8ea1@gmail.com>
Date: Tue, 16 Jul 2024 19:29:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf archive: unpack to correct dir given by perf
To: Namhyung Kim <namhyung@kernel.org>
Cc: vmolnaro@redhat.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yuan Tan <tanyuan@tinylab.org>
References: <cover.1720372219.git.royenheart@gmail.com>
 <18fa10628f1e037753244b438b2a08b20d611135.1720372219.git.royenheart@gmail.com>
 <ZpCyf6ulH-8dRBu4@google.com>
Content-Language: en-US
From: royenheart <royenheart@gmail.com>
In-Reply-To: <ZpCyf6ulH-8dRBu4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/7/12 12:35, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Jul 08, 2024 at 02:04:31AM +0800, Haoze Xie wrote:
>> In perf-archive.sh, the code segment that defines 'PERF_BUILDID_DIR' is
>> advanced before 'unpack' operation for subsequent use, followed by a
>> 'mkdir' operation to ensure that the dir exists. Symbols in 'unpack' will
>> be extracted to correct dir given by perf.
>>
>> When '--unpack' param is appointed, the symbols are extracted to '~/.debug'
>> folder by default, without using 'PERF_BUILDID_DIR' given by perf. This
>> will cause perf to be unable to find the correct buildid's path when users
>> configured buildid.dir in 'perf config' or used '--buildid-dir' cli param,
>> since perf will read these params and put them in 'PERF_BUILDID_DIR' env.
>> 'perf script' and 'perf report' will use the env as the basis for buildid
>> indexing.
> 
> Can you please add an example command line and the output for the error
> case?  It'd be helpful to understand the problem more intuitively.
> 
>>
>> Fixes: e43c64c971e4 ("perf archive: Add new option '--unpack' to expand tarballs")
>> Signed-off-by: Haoze Xie <royenheart@gmail.com>
>> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
>> ---
>>  tools/perf/perf-archive.sh | 28 +++++++++++++++-------------
>>  1 file changed, 15 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/perf/perf-archive.sh b/tools/perf/perf-archive.sh
>> index 6ed7e52ab881..f29bbc129056 100755
>> --- a/tools/perf/perf-archive.sh
>> +++ b/tools/perf/perf-archive.sh
>> @@ -23,6 +23,19 @@ while [ $# -gt 0 ] ; do
>>  	fi
>>  done
>>  
>> +#
>> +# PERF_BUILDID_DIR environment variable set by perf
>> +# path to buildid directory, default to $HOME/.debug
>> +#
>> +if [ -z $PERF_BUILDID_DIR ]; then
>> +	PERF_BUILDID_DIR=~/.debug/
>> +else
>> +	# append / to make substitutions work
>> +	PERF_BUILDID_DIR=$PERF_BUILDID_DIR/
>> +fi
>> +
>> +mkdir -p $PERF_BUILDID_DIR
>> +
>>  if [ $UNPACK -eq 1 ]; then
>>  	if [ ! -z "$UNPACK_TAR" ]; then					# tar given as an argument
>>  		if [ ! -e "$UNPACK_TAR" ]; then
>> @@ -65,25 +78,14 @@ if [ $UNPACK -eq 1 ]; then
>>  		fi
>>  
>>  		# unzip the perf.data file in the current working directory	and debug symbols in ~/.debug directory
>> -		tar xvf $TARGET && tar xvf $PERF_SYMBOLS.tar.bz2 -C ~/.debug
>> +		tar xvf $TARGET && tar xvf $PERF_SYMBOLS.tar.bz2 -C $PERF_BUILDID_DIR
>>  
>>  	else																# perf tar generated by perf archive (contains only debug symbols)
> 
> Off-topic.  I'm surprised by the comment placement.
> It'd be nice if you (or someone else) can update the whole file and
> remove the unnecessary whitespaces altogether.
> 
> Thanks,
> Namhyung
> 
> 
>> -		tar xvf $TARGET -C ~/.debug
>> +		tar xvf $TARGET -C $PERF_BUILDID_DIR
>>  	fi
>>  	exit 0
>>  fi
>>  
>> -#
>> -# PERF_BUILDID_DIR environment variable set by perf
>> -# path to buildid directory, default to $HOME/.debug
>> -#
>> -if [ -z $PERF_BUILDID_DIR ]; then
>> -	PERF_BUILDID_DIR=~/.debug/
>> -else
>> -        # append / to make substitutions work
>> -        PERF_BUILDID_DIR=$PERF_BUILDID_DIR/
>> -fi
>> -
>>  BUILDIDS=$(mktemp /tmp/perf-archive-buildids.XXXXXX)
>>  
>>  perf buildid-list -i $PERF_DATA --with-hits | grep -v "^ " > $BUILDIDS
>> -- 
>> 2.25.1
>>

I have two machines A and B, I use 'perf record' and 'perf archive' to get
a buildid archive 'perf.data.tar.bz2' on A: 

$ perf record -a -g -- sleep 1
$ perf archive

then I transfer 'perf.data' and its buildid archive to B. On machine B, I
use 'perf archive' to extract the buildid:

$ perf archive --unpack
$   Found target file for unpacking: ./perf.data.tar.bz2
$   .build-id/d1/a727ab038085dbbb50e74c812e5a6e8502e8c7
$   ...

But when I use 'perf script' to view hotspots, no function names are shown:

$ perf script
$   No kallsyms or vmlinux with build-id 
$   251c1248b97a17df394058a189dffe381169ddcd was found
$   perf    1770 [000] 1022235.467607:          1 cycles:P: 
$           ffffffff8ae9ceb6 [unknown] ([kernel.kallsyms])
$           ffffffff8ae15af5 [unknown] ([kernel.kallsyms])
$           ffffffff8ae0f83b [unknown] ([kernel.kallsyms])
$   ......

The problem is, I used 'perf config' to change buildid search path before:

$ perf config --user buildid.dir=/usr/local/symbols
$ cat ~/.perfconfig
$   # this file is auto-generated.
$   [buildid]
$           dir = /usr/local/symbols

But 'perf archive --unpack' just extract them to '~/.debug', which makes
perf can't found right path to search for buildid info. If I add
'buildid-dir' param to replace buildid path defined in perfconfig, problem
can be solved temporarily:

$ ./perf --buildid-dir ~/.debug script
$   perf    1770 [000] 1022235.467607:          1 cycles:P: 
$           ffffffff8ae9ceb6 native_write_msr+0x6 ([kernel.kallsyms])
$           ffffffff8ae15af5 intel_pmu_enable_all+0x15 ([kernel.kallsyms])
$           ffffffff8ae0f83b x86_pmu_enable+0x1ab ([kernel.kallsyms])

The code that determines the buildid path is in the 
'util/config.c:set_buildid_dir' function, which will generate
'PERF_BUILDID_DIR' var.
