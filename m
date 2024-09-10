Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FBB3C0C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Sep 2024 00:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725927437; cv=none; b=FRTZCcKsDfsFmFoMP/MPHCEZEhuNoTyOQF9ORfARQ55BoghGVc4t2+Q9Zlsrp90osxwm/Jl7QsMHT3ZgF9jm5IIHNxb8GjjECwfvp38Lpm15lNl/RQZMCTXRM2h2mcADBpPLfvxFGdz0Q+EFhtWqGrqoAJy9M2+vIn+tzIEbN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725927437; c=relaxed/simple;
	bh=EsQJOobOZzC/f92L4F/REg/2Le1tcr1tC2pQdGGh87U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsrEMu01xa8yNAWxxLWYRFwksqpc7AKTDInaXhrhvI9jdhpXIYHBIdzDHIR1yPV/RrASVkgF7bptW4gL94RLgq+48jCsAFqoWR+7obmhR+m/dP6QsZEDYX3JWYQ55hN7YSDs+RhsxCORdcI24aLuO5pv/jNP8Rc6DoAZPj7LueI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f6BXwNd0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f6BXwNd0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2068a7c9286so45649635ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Sep 2024 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1725927434; x=1726532234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITZxX7UiM8LQ0zk0XrwG6zjEJ0Wb/l4KQMatlFcav2A=;
        b=f6BXwNd0r5OwpDTyOUd2jZkhDbRx8YzxOGw1ShqiIrcaDriFxjft1eY4Tn3cC25hQu
         vUrStPY1Pr7uUcg9PUCFEyW1b2zIridRJZZNi+lovq8SFl3DUx7R5T3OKDKT4ghoHWoo
         NqtwH+/uw+oBnJ4o4iwYjc6vicI30K1blzIj6G0MtK+gDwExuWajQlRYAOE/R8iNqDKO
         fMEWkqF05mwweqx0V2jXSh8OAOCMQt/tBFw0uJI6BXcs42MOslyyxTZQum3qzOvc8cjI
         EfloOv5mD9SEuW0yHT+433T61BCBy/DS3fnbdtQVM3cfFQI2iJDwiluKo1/tUlKKT3ey
         TY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725927434; x=1726532234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITZxX7UiM8LQ0zk0XrwG6zjEJ0Wb/l4KQMatlFcav2A=;
        b=Hv0mELXnTBYyQ1DHysohfbfQpRktx652pRfGipB0DZoEfupCYThpLCpiGOTa/FKZrt
         TA8c/Nxg/vi618KgE4pPeEQjPy11MfZgde4UBL8OzF3Cjrl+cCP0hGPfBuNM376mHQTV
         Id4bclVUrjfzaOl0uwDEwpbTmLBro73GrH+pmWTIPSipmNWRxHF/VZ0/L7c70QcTnhxj
         ouoFQJTh6/xzfu6Tu5p+OR2frDrmnno/kRR/y/OZb9Bk/OFK991IruwZH5P9mjxvHdue
         DNmmmIn4EfediQdcyq8TYKrG8jN8g3NN/X2WEVGZJTT/GSBwZRvtHUxdPaaQZpbwDCJ8
         wuIw==
X-Forwarded-Encrypted: i=1; AJvYcCX3PCOO1DbjOEFRkTxgrIFGLmoyFkWiqHvTCV63psFQBzGOG8H8L+tB2rTGVXqYyjFtGXAhNfX7e2JUZtJZ8APZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwyB9Ir+ix1k8v/5eegiNOUxsVNTwCAIcMqhmUQ7leetUm3sMgt
	zSwmZsejCNtRtIF5DeghyLJxd91RQH74Hn1dMIN4JExKIOScV1TaU717pK5JcVk=
X-Google-Smtp-Source: AGHT+IH75Vt6xA+IGUZOhqCTzuuJDlJSOYaLbDTCkMHJ4LzN16Burqoa7iZR7nYEWaEGchZzuNuM3A==
X-Received: by 2002:a17:902:f684:b0:1fd:96e1:801e with SMTP id d9443c01a7336-206f05fa9ebmr159881165ad.51.1725927434108;
        Mon, 09 Sep 2024 17:17:14 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eef241sm38937055ad.144.2024.09.09.17.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 17:17:13 -0700 (PDT)
Date: Mon, 9 Sep 2024 17:17:10 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: Add perf_evsel__id() function
Message-ID: <Zt+QBqsP+hgnG3uu@ghost>
References: <20240823-perf_evsel_get_id-v1-1-0ffa204c4164@rivosinc.com>
 <ZtkyCWXVjnn-hjUT@google.com>
 <Ztn/mRDqPSpmliWq@ghost>
 <Zt92ADG9_W4ujarg@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt92ADG9_W4ujarg@google.com>

On Mon, Sep 09, 2024 at 03:26:08PM -0700, Namhyung Kim wrote:
> On Thu, Sep 05, 2024 at 11:59:37AM -0700, Charlie Jenkins wrote:
> > On Wed, Sep 04, 2024 at 09:22:33PM -0700, Namhyung Kim wrote:
> > > Hello,
> > > 
> > > On Fri, Aug 23, 2024 at 11:58:38AM -0700, Charlie Jenkins wrote:
> > > > Introduce perf_evsel__id() to collect the id of an evsel. It is not
> > > > currently possible when using libperf to determine the id of an evsel.
> > > > This will allow applications to link the id returned by PERF_SAMPLE_ID
> > > > to the event being sampled.
> > > 
> > > I'm not sure what's your use case.  We have evlist__id2evsel() to
> > > convert sample-ID to evsel already.  It'd read the IDs from perf data
> > > file.
> > 
> > That function is unfortunately not exposed to be used by applications.
> > This patch is for libperf, not for the util internals of userspace perf.
> > Since I am using libperf (and not the python wrapper) I am collecting
> > data directly from the mmap buffer and not from the perf data file. The
> > mmap buffer only contains the id of the sample, and no way of
> > associating this id with the evsel that is backing the id using only
> > libperf API functions. A libperf function that provides a pointer to the
> > associated evsel could be another alternative to this. However an API
> > that returns a pointer to the evsel is not very useful as libperf
> > applications cannot read members of perf structs, as the layout of perf
> > structs are not part of the API.
> 
> Right, thanks for sharing your use case.  The libperf lacks the API to
> map event ID to evsel.  And perf tools access the internal data struct
> in the libperf which is not good.  But making it a proper library will
> take a lot more time.
> 
> > 
> > > 
> > > > 
> > > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > > ---
> > > >  tools/lib/perf/Documentation/libperf.txt |  2 ++
> > > >  tools/lib/perf/evsel.c                   | 10 ++++++++++
> > > >  tools/lib/perf/include/perf/evsel.h      |  1 +
> > > >  3 files changed, 13 insertions(+)
> > > > 
> > > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > > > index fcfb9499ef9c..69c1d7efb659 100644
> > > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > > @@ -94,6 +94,8 @@ SYNOPSIS
> > > >    void perf_evlist__enable(struct perf_evlist *evlist);
> > > >    void perf_evlist__disable(struct perf_evlist *evlist);
> > > >  
> > > > +  void perf_evsel__id(struct perf_evsel *evsel, u64 *id);
> > > > +
> > > >    #define perf_evlist__for_each_evsel(evlist, pos)
> > > >  
> > > >    void perf_evlist__set_maps(struct perf_evlist *evlist,
> > > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > > index c07160953224..765b17045342 100644
> > > > --- a/tools/lib/perf/evsel.c
> > > > +++ b/tools/lib/perf/evsel.c
> > > > @@ -484,6 +484,16 @@ int perf_evsel__disable(struct perf_evsel *evsel)
> > > >  	return err;
> > > >  }
> > > >  
> > > > +int perf_evsel__id(struct perf_evsel *evsel, __u64 *id)
> > > > +{
> > > > +	int i;
> > > > +	int err = 0;
> > > > +
> > > > +	for (i = 0; i < xyarray__max_x(evsel->fd) && !err; i++)
> > > > +		err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ID, (unsigned long)id, i);
> > > 
> > > IIUC this would update the place pointed by 'id' for every fd then you
> > > will get the last ID only.
> > 
> > Yes I have a misunderstanding with how this is supposed to be written.
> > Can there be multiple ids associated with a given evsel? When parsing
> > the data in the mmap buffer, I want to be able to associate a sample id
> > with the event encoding. I suppose an API to get the evsel from an id,
> > and then require libperf applications to search some data structure to
> > get the associated event with the evsel is reasonable.
> 
> Yes an evsel can have multiple IDs as it can have multiple FDs.  The
> evsel is an abstraction to keep related events together and they are
> actually opened for each CPU and thread, hence the xyarray.  Each opened
> event (for the evsel) has its own ID.

I see, that makes sense.

> 
> You will need an array of a same size of file descriptors to retrieve
> the ID info and also a hash table to map ID to evsel.

I will extend this to be able to support returning an id for every open
FD.

Right now in my application I have a hash table to map the sample ID
back to the evsel.

- Charlie

> 
> Thanks,
> Namhyung
> 
> > > 
> > > > +	return err;
> > > > +}
> > > > +
> > > >  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
> > > >  {
> > > >  	int err = 0, i;
> > > > diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
> > > > index 6f92204075c2..1457e5a46b28 100644
> > > > --- a/tools/lib/perf/include/perf/evsel.h
> > > > +++ b/tools/lib/perf/include/perf/evsel.h
> > > > @@ -41,6 +41,7 @@ LIBPERF_API int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx
> > > >  LIBPERF_API int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread);
> > > >  LIBPERF_API int perf_evsel__disable(struct perf_evsel *evsel);
> > > >  LIBPERF_API int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
> > > > +LIBPERF_API int perf_evsel__id(struct perf_evsel *evsel, __u64 *id);
> > > >  LIBPERF_API struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
> > > >  LIBPERF_API struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
> > > >  LIBPERF_API struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
> > > > 
> > > > ---
> > > > base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> > > > change-id: 20240822-perf_evsel_get_id-f7e11f15504b
> > > > -- 
> > > > - Charlie
> > > > 
