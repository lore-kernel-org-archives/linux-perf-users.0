Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A4042CB07
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791361866; cv=none; b=fmKsfa/Ho9iwIHfdQwXsBWlV6dZaYl56UEgWMsSNb9V+1ERru/N7xoERurzYY/SBTYtOyZ+Arr6+DTAzCwzuIbIsvn9mEejZcCB+UZZ0htIrcKzTgSnf67qjS9ZvxYF3OrrttSvDudS49yZtEPnn0HjpXOF8Y5457JC0NDJfr9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791361866; c=relaxed/simple;
	bh=9pfrJQvbXPTXAs7usrGS/ac0n1oyVbNYxeq49UVm6fY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMfdOZjOs/CHYgpQFJ+8yOGHdDUAsG8O1LF+RXacx1mZSswdWHsp2yRs1pr3qcyywjDNOpHrcbbJ/f/EGrCT+VOQPto0/kiFFMVHsiL9FjfZuqdoGFqM+O+bgRZZNmmNB4QzJcu1kbO2PbjhsqR+x2B+wkz40X6AXZRP1gUqPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H90rS2lD; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H90rS2lD"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a17f65ab8bso3040295e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 07 Oct 2026 01:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791361862; x=1791966662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z1JaVbIvVyJ1UmpioILy1Ttyxf2JZ8HMV5yk2EbJ/oI=;
        b=H90rS2lDz93Zrh390HldScEfGzTf16enLdqivL11kq/PxQ6o0x2eeJIiRCW5m7FAyM
         /nkhkOop4w3HQL2cw557AfPW6dgKAnvnBaXS6ODX90PiomD4mKcpSPJTyY+XmIsBJQHo
         7XIOjRVlmhRtPNklWNqjqMDZAvcYuWAnV6lWZ+QlgppWD0YCNDp8OuctFaAV4dhPWWaO
         Q3e42346PIMAB0Y8W2lsqcE0B2XL96yyOHZSqi6NevCBiebGBmJ7HnLYXD54X9TcuOBo
         DF4tEZZP3wG1Mx4HhzSdHDFYoso8z2/unslWpIpZQlU+hFk9RIp6KDw4pP6USmWCUXG5
         Xx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791361862; x=1791966662;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z1JaVbIvVyJ1UmpioILy1Ttyxf2JZ8HMV5yk2EbJ/oI=;
        b=b57o7UTqhsDGSYDIzE22H25zO6xI0GvU65Ym+AkCLe+Rz/68mrn5OLXm9YJl1mQsS3
         zscV2j1UXHliP+xP0UazqnBBGMTfxWt+GNQoVoDaIb6Jd76WNjOB14wEbLdqdXGGnmBs
         gTFJqxyaWcu39P1zBrwNvyGE9QhtQj/V3PBRd0zdgUb/ElVAsES9adNcNbW812fEdeni
         basfNaVaQLX6shz/DpQjIQWOOMoGIBh2VrL5aWEfVygawQ5MKLu3RowoPGCtHRiIbGnL
         Xc/3EDGkJQgarpNwcA7Nkeanp5Q86VC02pGUJsR1QfrXC6SayuikusexSJpOu2BGupoI
         vWsA==
X-Forwarded-Encrypted: i=1; AKwUvBzGyF7M3ukUWRioSInPTxPw9AEC/2mdi+F+Xp6HWMlZrSJLmhhJQj+AwoGX03KuAE62wNP6SWgu6432sqWsSd9d@vger.kernel.org
X-Gm-Message-State: AFuF++k5tWvTLUmScg2eSfdVusDnmfhBVuZgYrQhU2l/s6G5+EtbcM2I
	zHxgeXb5SdRtaZs0BM/UKEpM5Gajx+FBt4YJ48sMcTivLOxPUTdc6e90
X-Gm-Gg: AYBFou1lBnxfhePI/+KK0npC/4slpfcKY4HxWvpBtQQHj1RD04NCQ1hn7AQ7M4EzAbA
	v/Y3iqbBcvw2nyrc3aK6rc2HPWs158IEV56RAa3UbtR7qIon1Hn6Fz3o+9BIBT3DUDtjezxl2q8
	G3i6Rw1wk3mEFIKZ31nyCLP24rcHgDZh1HJzOqQyG8NWsuJ8c2X7RVh7X90AlnQp8xuY9Oxp9Wv
	Zqzt3VvbHkVKIbgJ+7N9LLT69E2SngDNvRU/OLSdNrOT5t76DcWdf5DuOHeLczG7kkuZiuhz7+k
	mb70OcFUU2sKlDejQqIqgwsbNlxNKo9i+B3BIr5ic+iwE7aqlolDBi/bYrDsbajYLcvKlNbv790
	Y209joHugoWdP6HQWc53KvXJTMTcFU3Mv+B+v2/jVl+R6LGUnz5bMNSvS23jyfSC6rXblqKbHMQ
	gv8S37Z/C1+R9VCRUO43Og/Im0dm5Tnkq8C2/r1tgyExNRuhaTSahnHEcth0tPxrh3aawt7GTq+
	dQfog==
X-Received: by 2002:a05:600c:3f14:b0:4a0:1c94:7042 with SMTP id 5b1f17b1804b1-4a1802eab45mr23342815e9.8.1791361861821;
        Wed, 07 Oct 2026 01:31:01 -0700 (PDT)
Received: from localhost (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm49071365e9.14.2026.10.07.01.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 01:31:00 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Wed, 7 Oct 2026 10:31:00 +0200
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 0/6 v1] perf test attr: Fix the re-enabled test
Message-ID: <asYDREqTrh9ZDUhm@localhost>
References: <20261006161309.3078488-1-acme@kernel.org>
 <asWLmvF-3YtoKJ7j@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asWLmvF-3YtoKJ7j@google.com>

On Tue, Oct 06, 2026 at 05:00:26PM -0700, Namhyung Kim wrote:
> On Tue, Oct 06, 2026 at 06:13:03PM +0200, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
 > The test passes with 'perf test -vv attribute' on x86_64.  The AMD
> > encodings come from the amd_pmu_event_map tables in
> > arch/x86/events/amd/core.c.
> 
> On my machine, the current tmp.perf-tools-next which contains these
> changes fails like this.
> 
>   $ tools/perf/perf test -v 82
>   ---- start ----
>   test child forked, pid 931585
>   /home/namhyung/project/linux/tools/perf/tests/shell/attr.sh: line 20: python: command not found
>   ---- end(-1) ----
>    82: Perf attribute expectations test                                                 : FAILED!
>   
>   === Test Summary ===
>   Passed main tests : 0
>   Passed subtests   : 0
>   Skipped tests     : 0
>   Failed tests      : 1
>   List of failed tests:
>      82: Perf attribute expectations test
> 
> The below patch fixes the problem.

still without your patch:

root@number:~# perf test attribute
 82: Perf attribute expectations t: Ok

 === Test Summary ===
 Passed main tests : 1
 Passed subtests   : 0
 Skipped tests     : 0
 Failed tests      : 0
 root@number:~# grep "model name" -m1 /proc/cpuinfo
 model name      : AMD Ryzen 9 9950X3D 16-Core Processor
 root@number:~# uname -a
 Linux number 7.2.7-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 21
 18:25:57 UTC 2026 x86_64 GNU/Linux
 root@number:~#

 I reproduced the build failure in an ARM64 Debian Trixie machine,
 applying your patch to try again.

 - Arnaldo
