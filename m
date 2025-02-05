Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEF7DF59
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768020; cv=none; b=nwbNs0i7Wm1Oppj3aoLclzYlksNzGLUgUpwvG/3FwOVzXyJEi8YGloQ28KwIciHCAC8IVFEWBrXJcJxSgwGXsR5sGfdTut2HAnLWjh+RvjnX77dnQraZbhveM9y1Wc/SXeqmK3VrlVz3mgbHAri2N89O6UWzHq7UMe+KNS5r0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768020; c=relaxed/simple;
	bh=cDpSf7K63szEn5MofpSKLWQVoazZzcXhynJclxx9fgg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I7vpOIjkFh+n3HfV0quVOCPD+RGG47gp380EbQke/Ucd/GyIi2WyPt3sWme5NrpR/wk3MbzfD5uEcpsG7lHjvZ31gegOqORC0imYWhu2RsTcn1vwPwYOuHfcZhLnuoitf4OllntXOgvASWeFDnDs1E6Sy3Nngx8Wg8QChr9YYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu; spf=pass smtp.mailfrom=maine.edu; dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b=Y339i1pP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maine.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maine.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="Y339i1pP"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6f0afda3fso840927185a.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 07:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1738768017; x=1739372817; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=41bSJri6zeqVSF2ytQuaV17DWUgqUBZ8rU11L7eRH7w=;
        b=Y339i1pPotHeO/RPrOUZaCh+zrlT9uLnDJFUdJnpE1vwZVY+vDDecnOnZqxryAkEGC
         ae1Fihsd4953zTPtDc0KI3bexafJdnxosP6Ia4wle+0Pg6ZINCglmfOJP/Ff4ftCptmd
         WG7aaNyUcX7vS5vxqG6by5zUukS/d6drdb8iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738768017; x=1739372817;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41bSJri6zeqVSF2ytQuaV17DWUgqUBZ8rU11L7eRH7w=;
        b=EvRRLS/l8uwm3kPp6UThuSkY5EkiU9pjGZmW548z4jF2/7Uf//T0zHluU3RlkBYFQj
         STb1KAK6uiM0A4qyzj+LLHRv9iMP614peCBpUe4w7SmFAfK41WxFvxwWOzGCzu7FqUsv
         00epLBzMAwJQAN782WbCqtH/Z9iwxtbiyTyL6YF/bht5vEn6WteiXeG8ZmajhaKFFQN+
         XwvOweRwb8+XE8mPoOC8JZIjVYvpjSk5P1KpctzhnzAQvc4e1Bfk3Fe1sZmQau6ueCE6
         4tjTH11p+yQI1Yfgw1XPYW4IS9Jt3soaWvM4neUoK1Ui/QvygYvJZ6vPJVuE81w4V20X
         CYLw==
X-Forwarded-Encrypted: i=1; AJvYcCXWCFeMz7WirpSB1ZnZmGXxPtOW9gIIdo1dCmfj0gFDGFwxZFrrTfrT4I8Qn3DdNwnRSk7pWystvVlXWOJxD+jr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+4Hhr2hTyp0ze9P7WvSnRBQ9Hc0CLYXhYVwWLnqu9Wphhowt
	WAXhr9Q4kcDYMV5VWLj31pYs2N3EGiiNaZmL3ojkJZ6pJ0UDmYRowiXRGXvkng==
X-Gm-Gg: ASbGnctLAZ6K+aQW3O9/f18N/oxhsZIOf5aK99mAE+61+WqCB+M2YTnb/lmRXBmxpsW
	fVDqDQ5V2Gq7E5Sro5YhxFR5mA3m0AfmKLFyzRbOrT+ThX49AN/Uf2j+8XKMi7iwFzbxlqM03h6
	JSohlBQ8UKEy+9xuaF+IClreywUu+2w3cUV80qyaWxMg//wvr8mROSg5MsjkfiLWQZyEyAQ8I/T
	0NkAo2lQoziTysC/pcYBQJErZM2x3ex8/Ke1UycdemMKNrs39NWfqTPeJ3w1I1dOhkc4O8ww/z8
	34obMZpxvaWRn4jz/5Y+CGrjQAbAs+rMaJwQow==
X-Google-Smtp-Source: AGHT+IGsA3qsLqyaOvqUI19MkoAMi9oWQ9uofuW1yU0R0BT1yXEQ4f1B2pdSCwg5Py+LpxQoAmAyPA==
X-Received: by 2002:a05:620a:4246:b0:7be:3cec:ec4d with SMTP id af79cd13be357-7c039f9950dmr322585685a.24.1738768017372;
        Wed, 05 Feb 2025 07:06:57 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a9047a4sm752748785a.80.2025.02.05.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:06:56 -0800 (PST)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 5 Feb 2025 10:06:55 -0500 (EST)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Vince Weaver <vincent.weaver@maine.edu>, Ian Rogers <irogers@google.com>, 
    Stephane Eranian <eranian@google.com>, 
    "Liang, Kan" <kan.liang@linux.intel.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf/core: move all of the pmu devices into their own
 location
In-Reply-To: <2025020535-curvature-citable-ab6a@gregkh>
Message-ID: <6cdaf5a4-0043-5cde-9b48-06fb7c1fd9e2@maine.edu>
References: <2025020304-chip-trench-4e56@gregkh> <87pljyyx68.fsf@ubik.fi.intel.com> <2025020426-spool-refreeze-2870@gregkh> <d689243f-9b25-40db-98b6-e032a6b27c62@linux.intel.com> <2025020408-apron-fled-d29e@gregkh> <6edcf7f8-d496-524e-2250-49284dfb55e4@maine.edu>
 <2025020447-gyration-wireless-f7da@gregkh> <CAP-5=fWT5J0svFsA-jqvE4P=NnTdrsKPF9x6JHkUEDp-vBd_1w@mail.gmail.com> <2025020444-savage-latrine-0c31@gregkh> <97541134-7c32-94a8-7642-a82f3292dc38@maine.edu> <2025020535-curvature-citable-ab6a@gregkh>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Feb 2025, Greg Kroah-Hartman wrote:

> On Tue, Feb 04, 2025 at 08:21:17PM -0500, Vince Weaver wrote:
> > 
> > it doesn't matter if it's a one line change, your proposed change breaks 
> > userspace.
> 
> It breaks broken userspace :)

no, it breaks working code that's been working for 15 years, apparently on 
some whim by you.

I thought we didn't break userspace.

> > I thought the rule was Linux didn't break userspace.
> > Has that changed recently?
> 
> No, which is why I am working to fix these tools so that it will not be
> broken.

that... is some impressive doublethink.

> > libpfm4/PAPI are widely used and deployed and in some cases possibly 
> > statically linked into other projects.  It will take years for the change 
> > to filter out to all users.
> 
> Great, as it is easy to get this type of fix into the stable kernels,
> and then fix these tools, by the time those old systems eventually
> update to a newer kernel version, it should "just work".

no, that is the worst case scenario.  PAPI is installed on older systems, 
often custom non-vendor packages.  So if you get this into stable then 
these older RHEL systems the kernel will be updated suddenly breaking the 
users with no warning.

Even if we manage to get a change into libpfm4 and PAPI it will probably 
be months before the next stable release, and again people tend not to 
upgrade PAPI releases that often.


> I'm fixing up the bug where all of these devices accidentally got dumped
> into the root of the device tree in the system.

is this a "bug" or just you shuffling around files for no reason?

> Again, /sys/devices/ is NEVER guaranteed to have specific placement,
> that's the whole point of sysfs in the first place.  We can, and do,
> move devices around in there all the time (even every other boot), it's
> just that some tools accidentally didn't realize this and now need to be
> fixed.

great.  Slap a note about this happening in the appropriate "deprecated" 
file with a timeline of 5 years out or whatever, and then when that comes 
around then send your patch.

Vince Weaver
vincent.weaver@maine.edu
