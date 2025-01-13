Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55331B2199
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 18:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736794775; cv=none; b=WTYaRL4IOoc9BiDVZSbc/gG3J7LlApqksSdLn/7bC/9Gab48rB0Rze2ZbVHW61lTkFLg51JhrLKJKbSNNRxKw1xbXJoQ0ANZ4Tl330M3jiQGV1zKJbxmev0tUfb9Z81YkpeYG5Co917lITC5x1nj8tCUiZeWooojCFLrY5BKiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736794775; c=relaxed/simple;
	bh=eDkSaHKisJUZ13hHtYwmN4Xauvlba9YzJ2rNjB0q1Ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLTExmFySOB3SU/tOGoITYYyCQ1ypVzoHEd2SAzUSFzyXQ1DJtvsUs+eS46Mqm6ceUPYZOEkF67w6Y4SCBSQttykpZtQaaoL720STq3mTJD5BsMUY/nYRw+qWJ83ZfAZalbapGAyEsdBA/KFMTOAgjjjjma1FvFsWnvkSrCf1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sIoviWWW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sIoviWWW"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2161eb95317so81698905ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736794773; x=1737399573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oucMJkx6ro9PPa7y1jrDOx4rSBXUZuES3PIBtiAphnY=;
        b=sIoviWWWS0Cyc0Y7VG2B2832pYXjGLEsQOtUCFMXBMF9H74c5vyGK5sfql+3Oqs08X
         vm8KzrHOEEidrM1p61h06NhQ6RVS8RMIXr1iH2+WCNWftjm1bfYRM8z8Q3EIExjZLAUk
         qRjYuGDTboUDS2WC3czen5IxXRgQDX5jsnty4tARILahLicXAtQ2xV3IU2GoxdJJjc2l
         ZontMdKfC9ZqToUkHVUjXygIJJ3trpvtIZBn2QMMtbDkHe9EW+YuN8NrkuOS+KNTKWy5
         GevHFwzT8762us+r3yiDEe2bNzwHw4gpqBOl1eP3XPtAPpuQ4PaSZGzyD9Y2l1TN1tQE
         8H8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736794773; x=1737399573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oucMJkx6ro9PPa7y1jrDOx4rSBXUZuES3PIBtiAphnY=;
        b=Mk4qvy3SvLAzovd3LniWSV/g3BAGNyrEIE05eRpDNmfCh34FnMLk0n4BmmSZg1huYF
         BR1JFLvkLiyzo4LAwPA1rt+WHba7SMdk4k5wN5FLoTZGsxD+PpCipHcc1SasBwEzutC1
         zeVWagQyj4/vjuzqVDU5PjxCIFFcAM+Mp8oBtYdcZfQo8uPCTqo+4t8MpOyie9uRAi9m
         YWlLU7KtEel2ZNlUeuALEKqPysbkhojp+gSCgnvZZSr4Z70oGg/Vi+Q/EDHqL6t22R6F
         5gjK58/cXCNs/oX6HPoS+bp/HuPf6bu7UpWCzOgULCzIUG+Vxd6EUD9z3k9B4xjmjmY8
         x7hQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZdCB8H0eATD9gHCzA3aTTfT2lhZc6OfcfkSLXzGZ/cUJcFY9KEcVynzkrYyLS1NqEvD9lrjRohPVZ6ikAi17@vger.kernel.org
X-Gm-Message-State: AOJu0YzJK0Zuiy5FAuU/SYDU91PfxcvNmH7MuADFiS+Oqyc36ng34kY4
	7LTgly125uzRru57rX9sDdJJG45XBJCXShNk6/NxSulf0CvjI7nJAvUsBgyxonA=
X-Gm-Gg: ASbGncvl6n1VfbmUzU+YDrVjCGS8gyZ7/cPnt8CpwikuKku7r/hEXcpp5w4wpllJKGa
	UMKlUfMQ12lE/v7mUuLu02x5bpdacVQoNGGj82dCQSWEX5tPfPpDI0pgvOfhZNqm4peoQkyUsAN
	zspX3jcqAWLoNsUWNCibR4dvNlOeXVmamFOhLrpXIlQPl0/cNcIVNcPLABGmi2zA7gMJ2bWK54Q
	Cfeush/26wEFkIHdq2ZroCAHjRIaWkjk9dtkfm7x4dcEsWWPFc=
X-Google-Smtp-Source: AGHT+IF4QVdzyukBMivdFlVyYWumc55Rbbg/jjOLDIJYUn9Ggcyr7/1DtytnRlcd4ciNzcdkBV2jcQ==
X-Received: by 2002:a17:902:c941:b0:216:7cbf:951f with SMTP id d9443c01a7336-21a83f4f096mr342220165ad.21.1736794772965;
        Mon, 13 Jan 2025 10:59:32 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:a6ef:43e8:dc9:f072])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219330sm56802405ad.132.2025.01.13.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 10:59:32 -0800 (PST)
Date: Mon, 13 Jan 2025 10:59:29 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Atish Patra <atishp@rivosinc.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf: Add PERF_EVENT_IOC_INC_EVENT_LIMIT
Message-ID: <Z4VikUrFuHocTXAl@ghost>
References: <20250106-perf_set_event_limit-v3-0-dbde0e90ddde@rivosinc.com>
 <20250106-perf_set_event_limit-v3-1-dbde0e90ddde@rivosinc.com>
 <20250113131812.GB8362@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113131812.GB8362@noisy.programming.kicks-ass.net>

On Mon, Jan 13, 2025 at 02:18:12PM +0100, Peter Zijlstra wrote:
> On Mon, Jan 06, 2025 at 08:07:32PM -0800, Charlie Jenkins wrote:
> > PERF_EVENT_IOC_REFRESH immediately enables after incrementing
> > event_limit.  Provide a new ioctl flag that allows programs to increment
> > event_limit without enabling the event. A usecase for this is to set an
> > event_limit in combination with enable_on_exec.
> 
> 
> Utter lack of WHY.

My usecase is being able to use libperf to calculate performance metrics
from running a program for X number of instructions.
PERF_EVENT_IOC_REFRESH can be used to stop the counters after the
instruction sampling threshold has been hit. This requires being able to
start PERF_EVENT_IOC_REFRESH as soon as the program starts executing,
which is a perfect application for enable_on_exec.

- Charlie

