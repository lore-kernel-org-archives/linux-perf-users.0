Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA6D2E172A;
	Fri, 20 Jun 2025 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441220; cv=none; b=lUFuEZc6P4ANlL46VGOwL5GON6m7YlW4sYCDMD9x07ObWFpnQuTFzbCIxktD65KtyJNoxsSyNbRrVsuXY1ukuC+F3xN4z8+DQh2CbIB8DB2IOAUleJIDWRUAwtnJeGogcFT/vt22/4zPcUgh/o1XccHNbPtAWJnCgJy2wScEkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441220; c=relaxed/simple;
	bh=OFWh618G+nN07dN1ddt6LCLr4FaHIYMhHdZ5Tjd6XVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oCtECwBKwWzAY74ZHGOJCLU70n0U1yx52BELXE1/yKvxV/jcVU4KvUeD59wFV17jVwDYuUBLmzo7DOoV34l2gckng0WmdEI0CaHbCh/KJinwYu6B5rbsfpolsFIrc3TWuY9MpE63hURM6fQeZg5I6T1pRGGCj1oltHUf+UczDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fic3Qe6F; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fic3Qe6F"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so1658709a12.3;
        Fri, 20 Jun 2025 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441218; x=1751046018; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrfa6f95rsQz82Z0z+vddrx+mjnxXRUvG8Wd94yuAao=;
        b=fic3Qe6Fq67WdkVw3WQ752xp1hoPPjkCPv8TBrjl83Oak4Wf6eaY+wO0tcNPsOnRq8
         RGCvdl+r7oTxGh+vBC/kSBpT9OK9wja5nvbSo+by63M6GAz/GB8ny8OdHaztUcoc8dtW
         ktrpKr6emB852kLrZqRrp6eOXNofFVosURznpfQFUQUO4HktNJGeLe59gj4m9fyf61bk
         IAyLryTdSuqDw05XVCf/MDsgvSAd7dGSUrUubv5tlCd+5t0dx6siHpMusB86ra6d/uXs
         tWXzxxXwgX0zSNPXNB52LPYD/tX5l51PNffU2o0ZzuiQzmztdfeEE55h7cv50DpMveuZ
         EC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441218; x=1751046018;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrfa6f95rsQz82Z0z+vddrx+mjnxXRUvG8Wd94yuAao=;
        b=naJErinFWvmQxViXKoLQJ+5L8ctsrOtA+khaJAcOm+5aHvsXz9omxVRiQTfCOdadVR
         jJMfD46wAjVIhOJ9kKdV7qyLrTfcx/YD9QlIYdMYuyhNM6+my2CGQTF3LaFqhKFuZgIE
         Mpgm6OVbGHkqu8bqAAJE7pBiSbMLgKnGB+L0kvjrPhhuxpfgvbnvXkTS56vl+9PnDdhu
         8D01sVVpdBoFoE9PorwCGEgAxoC/qatUUsjNC33r/5Ig0cGwqhtukJE7HwtCvAD6MTXM
         BpEF1/f/19DBuACTv5BweZmAZVgslj5X5tSwVi0IDmuidXyjXyoLE8QPzp4PyXZhULrx
         Wwsg==
X-Forwarded-Encrypted: i=1; AJvYcCW9oY/rsdxBBEKv+2Ze8XS4Jf4eGniU7xZfeF+jkBGxJLKikeD2NqkI7XYI46VYT6UJj02yOgWNEKKHfaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoBie9A+uXlFZ7SqO4pI7PIkf5DgZnHDQS9llTZRS7anr1qcKF
	u/5UIFfrydKptDMgeiOi6G1n3X/Qbgx/dVeTH6nwhcULGPez3fYldGIn
X-Gm-Gg: ASbGncu0cgqdH6Iw7pnm/cIV/rwKBLEAi8ov1ypkEBeIkBFwm1xCkts6780gB3bi60l
	aoyALFL0PKo4RzOFG4Zd/XkZSs8FKLRVpS2dE/MAVMBkfD9wE5FKQygc1GEXEMwSLeO7QbtUAXi
	67hwSdbf9AuSVzE0PRWs1Ol/7a5zvxiaNqa3tLOk2Yuu/hJjCyOz+ivx9obc9pb43fIpY1WwsKu
	AVXsYutRE5GbEh6m3xlXwNgz8is2PYfigxjOzlEf75EkJJNFAr3r8TMGwVzKeHWLvxdZ7Nf4j/l
	Q7ES0pH2YaHT00iXVjlQArUYZS64VNR1LdBdkRPhpp9ys2LT9f45BQ==
X-Google-Smtp-Source: AGHT+IE4pfEDuK4NvUg+ry5Rf4DYRoJ1U08Eu4uDQ0aEWXtK0+oZFw8hbBiESznwSJ4Y+sDyrsFZJg==
X-Received: by 2002:a17:90b:5690:b0:312:f0d0:bc4 with SMTP id 98e67ed59e1d1-3159d626112mr5266787a91.5.1750441217907;
        Fri, 20 Jun 2025 10:40:17 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::15bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d83ce860sm22864805ad.65.2025.06.20.10.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:40:17 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org,  linux-kernel@vger.kernel.org,  Peter
 Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,  Arnaldo
 Carvalho de Melo <acme@kernel.org>,  Namhyung Kim <namhyung@kernel.org>,
  Alexander Shishkin <alexander.shishkin@linux.intel.com>,  Jiri Olsa
 <jolsa@kernel.org>,  Ian Rogers <irogers@google.com>,  Adrian Hunter
 <adrian.hunter@intel.com>,  "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH] perf build: Specify that spellcheck should use the bash
 dialect.
In-Reply-To: <20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
	<20cce2b1-eaad-4565-817b-b094aecee0a5@linaro.org>
Date: Fri, 20 Jun 2025 10:40:15 -0700
Message-ID: <874iwa71mo.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi James,

James Clark <james.clark@linaro.org> writes:

> If we're enforcing bash style with static analysis shouldn't we also
> change all the hashbangs to bash? Recently there have been changes to
> change sh to bash in some of the tests so presumably the hard rule for
> sh is no more?
>
> In the past I've had to replace bashisms that didn't work in sh but it
> would be nice to have only one language to write tests in. I doubt
> anyone running the tests today is running somewhere without bash, or
> that changing it will break anything. If anything it will fix more
> bashisms that have already been written.
>
> Just for reference there are 34 #!/bin/bash and 42 #!/bin/sh in
> tools/perf/tests

That sounds reasonable to me. Writing portable shell is a hassle and if
we already assume a working /bin/bash in some places, I don't see a
reason not to use it for the others.

Regarding this patch, shellcheck will use the file extension or shebang
only if it does not find a 'shell' directive in a .shellcheckrc. So that
change will still require this patch.

I saw it was used in other places, so I assumed this patch was fine:

$ find tools/perf -name Build | xargs grep bash
tools/perf/Build:	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)
tools/perf/trace/beauty/Build:	$(Q)$(call echo-cmd,test)shellcheck -s bash -a -S warning "$<" > $@ || (cat $@ && rm $@ && false)

Collin
