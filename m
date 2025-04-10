Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC26281369;
	Thu, 10 Apr 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744282593; cv=none; b=CsvICx/YAMtyX60OsH8EiMKHL/A7jPX95x0au6Dxm785vZFHA7OVrfRZ2eYdeCdlNw7Fi9+EBPQk/APT08BKP3ehRES8fNcDwxwTHpdJWckl/k4eFIz9qlXWNcgLkG0HO++nMpG1w3hkG/B8VCi/o9hr6y5KHf3xhOaggmUAHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744282593; c=relaxed/simple;
	bh=qmUb5SCG0FCeX7A0GUYhS+E7gdF+eDJWyP8VwWfIE/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqwmXKMbhopiPXTHec3Nvq9NZX3QgPMnjRyjZ5FNXcUfAUMgtUaUkfG7pVUaviGL3xiWB8WvURcAqi8iaBoVfjE+S1Typk6q5ySw7iezKVXan84uLiVFxcXXZAKrP1BXJKyX72Ko1X4lAcO5oDwRrpqQyHOiOvsCAsXwcXsgz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3vcKCSTy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ELgFsRcH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3vcKCSTy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ELgFsRcH"
Date: Thu, 10 Apr 2025 12:56:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744282589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxSFCVZqgfyJslzQMneu/OUO8qGifnZ7r8Kr8VGaOAU=;
	b=3vcKCSTySTJpT9OnsNBVJmM3ZelGKa3zGpQglH1b5KAnjYgz7hzscL23/vxoY/q6uEajuW
	8zpmghmsbNvYN86G2+zFN+UPx03CmsPIjM5S1dQIY9l24rqYthj6n3rjAKaGEFKa6bWxxZ
	g3Y6N1GBcx19tIXYTGNZUWQlMUOv4bIlitD0vcnWfvW3t3yiYgCWZHs33XgEm+9MpiuY9H
	fRN9fR9k+IRtvvkVoUE/f7MZOCRwQ/u/KCyaQItxB3sYosEdcNiUbPJlHHJtFLmQqhfHP3
	pMJPWV6lIFUkr2bmDIfe4W6IrHHRfRxQ+xvcvZlNtT4x+kpIWF8iomJDZy6OhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744282589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KxSFCVZqgfyJslzQMneu/OUO8qGifnZ7r8Kr8VGaOAU=;
	b=ELgFsRcHNKUAQPWYJEGHuQL30/mfCRn32we0rykYyUQ752Jnc2S9hdp6KuROoQ3Edi20VB
	ImnBm2hXbzzFqPBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 19/19] futex: Allow to make the private hash
 immutable.
Message-ID: <20250410105628.cLaq6gVO@linutronix.de>
References: <20250407155742.968816-1-bigeasy@linutronix.de>
 <20250407155742.968816-20-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250407155742.968816-20-bigeasy@linutronix.de>

On 2025-04-07 17:57:42 [+0200], To linux-kernel@vger.kernel.org wrote:
> - Xeon CPU E5-2650, 2 NUMA nodes, total 32 CPUs:
>   - Before the introducing task local hash
>     shared  Averaged 1.487.148 operations/sec (+- 0,53%), total secs = 10
>     private Averaged 2.192.405 operations/sec (+- 0,07%), total secs = 10
> 
>   - With the series
>     shared  Averaged 1.326.342 operations/sec (+- 0,41%), total secs = 10
>     -b128   Averaged   141.394 operations/sec (+- 1,15%), total secs = 10
>     -Ib128  Averaged   851.490 operations/sec (+- 0,67%), total secs = 10
>     -b8192  Averaged   131.321 operations/sec (+- 2,13%), total secs = 10
>     -Ib8192 Averaged 1.923.077 operations/sec (+- 0,61%), total secs = 10
>     128 is the default allocation of hash buckets.
>     8192 was the previous amount of allocated hash buckets.
> 
> - Xeon(R) CPU E7-8890 v3, 4 NUMA nodes, total 144 CPUs:
>   - Before the introducing task local hash
>     shared   Averaged 1.810.936 operations/sec (+- 0,26%), total secs = 20
>     private  Averaged 2.505.801 operations/sec (+- 0,05%), total secs = 20
> 
>   - With the series
>     shared   Averaged 1.589.002 operations/sec (+- 0,25%), total secs = 20
>     -b1024   Averaged    42.410 operations/sec (+- 0,20%), total secs = 20
>     -Ib1024  Averaged   740.638 operations/sec (+- 1,51%), total secs = 20
>     -b65536  Averaged    48.811 operations/sec (+- 1,35%), total secs = 20
>     -Ib65536 Averaged 1.963.165 operations/sec (+- 0,18%), total secs = 20
>     1024 is the default allocation of hash buckets.
>     65536 was the previous amount of allocated hash buckets.

On EPYC 7713, 2 NUMA nodes, 256 CPUs:
				ops/sec		buckets
 -t 250                     25.393 (+- 1,51%)     1024
 -t 250 -b 1024 -I       1.645.327 (+- 0,34%)     1024
 -t 250 -b 65536            25.445 (+- 2,41%)    65536
 -t 250 -b 65536 -I      1.733.745 (+- 0,36%)    65536
 -t 250 -b 0             1.745.242 (+- 0,21%)    32768 * 2

Sebastian
