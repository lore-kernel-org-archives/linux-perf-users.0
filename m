Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2F3DE43D
	for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872595; cv=none; b=I+wABnmPDvhSBkSNT8yEuqEdH40taUXIaB8RY4Cxi/Mjr+bWqbQ1q21LkczvJNYfCKh+ZZVPJwxfCHQyI/B0MaDeuZfK5QgBJu/XE1rshm1xAVZa9Dtl1Q5KX8GKhCr2YgIYRaGFJe3ccPvHxWODhmX+l6s64SVJDbyyzZxaqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872595; c=relaxed/simple;
	bh=bw2PKfkeEdwE1nOrdCRw94f+4a2bIqm/xew1+TLymQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8B+fWue3GguBrQhWbgPVEDtv/tiGsjIZ8HPwEuilaldCMIkSI7oxE/o9E75TFrPjguEmgiCB7ADIpDvJrYyvXtsIB2ohhVWTSdVH6Kpa4Bua99JCHYDsOMNHDe2Fcek9c/DT3fHOx75KiAqwf8mO4Z1W8vczNS2MEX59cVX0IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49056b9f04aso51116865e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 May 2026 02:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779872592; x=1780477392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/mfvQTmje2KaryVvAvAb2JGEAPI/tuuIDCzzcfUK5M=;
        b=IC1XAqUg8qQh5DnWcER06mQ+Trq7rz8fV576leYdyLNU4xxc7iWnhG4fIRR8/C0ZPa
         awwXZU9Q/MI1wMm85exTpZKqV7UywsmbIb1iwzlgmPzO+ZPbL2mYiBC4a+BJlWyjuSni
         kXt91AYWNcXU33DyFVr7r+IXSrRxMZkrnJ4aft+rr9n0aRUJcRgPAfD6wZ27CxQRwdey
         r/fHjj218Xu1Xrf9EV0ygmuWwXlKplDUI/4pSjGZCR73xmHqVWRapUBXhTt8fXbcDAbY
         vfxhxgqZpXaRsaegQ8CfzAOq55CE9oUQ1/PUm65NCiAzi9cMjGb5XkQrbAoNcHACF0AR
         wC8g==
X-Forwarded-Encrypted: i=1; AFNElJ/H6ZMGRpJ+GXVrqOCQ4HaHcd0DyL29bb9+uHlmiwbK/hPte1z6yQU2QX5DHx3YXopJJ5KM+5AKmaMfalLkiNEG@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oepHMwLoJDlaPY4FXLmhNqIhe3p4UVadWKBI8Nt8eNN/lu2P
	xsIRtgFR9zY6BWAmTA8eppgfi/a5O9rbswD1ke9f0ioWbYuBDPD/SS3L
X-Gm-Gg: Acq92OGem3x5iJo8+pYc7vQ8fWX2VfIHxqPpPv5Yh+EUhiHFdfQ3WTU7vxvAfT64jkP
	TCskWtvCLOH+Z9TPI6si9tLiifVqBOv59IXrchr5Tx1NzLYrTaAoBXYXh8x1a/b0ffOAefIuh6r
	aNglIqv6t4Eh3N9CM9O408cAYiPLbxtHRinPlhvjCM1OtOXkqN37cRAKEWL6/H2Lz9KMUXT4C5Y
	bU+zqVJf8y1jeBCD/QUZzNg+RYnomeolDelitRlJcJ0cb4I+tc8yhg7TPcQeHDC8An5PcxkcFY5
	TPJSQ+0UwjaUyVmQpLHblAxr+FD6Ykai63kYzHvwLYxAUNLdZNobtyf1bUCef7casyJ+4WXvZcb
	u4kimTOxRdmQ2Bm9GIo9Rik7UpRolO43LCNJGeUUED97rjpgdSs8SuddsLo3Rnl5xATkHpWlOMa
	4Rehvco0b53B423t+I0E3xLhTFuFbk/LAoR+66
X-Received: by 2002:a05:600c:8b23:b0:48f:d5b2:7c1a with SMTP id 5b1f17b1804b1-490425aa7a4mr388212385e9.13.1779872591739;
        Wed, 27 May 2026 02:03:11 -0700 (PDT)
Received: from gmail.com ([62.197.47.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4907eae9898sm18436755e9.4.2026.05.27.02.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:03:11 -0700 (PDT)
Date: Wed, 27 May 2026 10:03:09 +0100
From: Breno Leitao <leitao@debian.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] perf bench: add --write-size option to sched pipe
Message-ID: <ahazPpAZ6YUnapDC@gmail.com>
References: <20260521-perf_bench_pipe-v2-1-720b6ff7f0fa@debian.org>
 <ahUCyRwNPKV1VAZ8@google.com>
 <ahXWIrGvsC3_gIkC@gmail.com>
 <ahZ_sr1bzkoul_tq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahZ_sr1bzkoul_tq@google.com>

On Tue, May 26, 2026 at 10:22:58PM +0000, Namhyung Kim wrote:
> On Tue, May 26, 2026 at 06:55:33PM +0100, Breno Leitao wrote:
> > hello Namhyung,
> > 
> > On Mon, May 25, 2026 at 09:17:45PM +0000, Namhyung Kim wrote:
> > > On Thu, May 21, 2026 at 09:15:37AM -0700, Breno Leitao wrote:
> > > > +		ret = write(td->pipe_write, td->buf, write_size);
> > > > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> > > >  		ret = read_pipe(td);
> > > > -		BUG_ON(ret != sizeof(int));
> > > > +		BUG_ON(ret < 0 || (unsigned int)ret != write_size);
> > > 
> > > Is it possible to return smaller values than required due to signal or
> > > something?
> > 
> > I tested this on a VM with the patch applied, running the ping-pong with
> > write_size from 4 B up to 1 MiB, including multi-process and single-CPU
> > contention runs (millions of iterations). I observed zero short reads or short
> > writes.
> > 
> > Looking at fs/pipe.c, this matches the kernel behavior for this access pattern:
> > the bench has a single writer per pipe and the pipe capacity is set to
> > write_size, so the writer never has to sleep mid-write, and the kernel does a
> > sync wake of the reader only after the full payload is queued.
> > 
> > EINTR is also not reachable today because the bench installs no signal
> > handlers and nothing in the call chain delivers signals to the workers
> > 
> > At the same time, I understand the concern and If you'd still prefer defensive
> > handling (short-return loop + EINTR retry) I can add it in v3 — happy to either
> > way.
> 
> Thanks for looking into it.  I think it's better to go defensive for any
> unexpected behavior or changes.

Ack, I will respin it, then.

Thanks for the suggestion,
--breno
