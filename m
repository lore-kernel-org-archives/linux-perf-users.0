Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5FC57319;
	Fri, 17 May 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715954848; cv=none; b=LrEK/hIAWysDZYL2TUZ7e/d0+5TiSKzydOOCvkzCzYm9poZftoMlvYC0sjdsX9x3SLXWe5yyWLeGTI3SUloG2SHB1f/hBCb3/B0FdkMhOYTTN+rdlC8WjlaR3mwseSCoDNueh4pYUEKdQbdGAfgwZ6BmJcse/6u9hiDwZIVZyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715954848; c=relaxed/simple;
	bh=tPP1Ft8vq89Koa9tWajFWgaUGoekzB0kwKoXTXQ9q6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkCzU5Ck4NBunNeZy0LZ8kuf1yIloNQ9u3e47fv2lHC2ZT6r/evQDmzbwPKLN37pi5BkJSwruVjqacKflkwwokZTJjNrqV2cewDwhy/VW8UW4umDi7pxhoSWNJvbF+X99HtvldnduPnF/yNHC35vDBMWcFbGJpjOo0GFLrXWZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-572af0b12b8so4835371a12.2;
        Fri, 17 May 2024 07:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715954845; x=1716559645;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPfvxDe6Hhh3qL31CNKs/kZFZpYqVBGETPWyqK12Ri0=;
        b=pQ8Fh6V7TSceo3tui2HSYdOZ+HSDv1+RO6L7JR70fUi2f2HlrHOaA/4J+XcgvIycFU
         jYB5VkEcMe1jHnz+inBxeGrvTVUbHAf6vyjC0QgUbwYGRpZtjrAL4+lXl82Qcp4jTm/5
         Ko5NjZRiIpE6TJl8BoQrKsJVOGAJ8BlGLntkwyNGFn6Tt/Mb9g8ZUdChZS+9S/TJuCQ8
         oX96uUra7eR1WToIaOTdvPnsifWRLOd8CsBrfeB9GEe2rKZAmj5M9iVWRkvwxsO1vEIY
         5MjNNl/tADBS/+Hc3DKkJV2IK49I0U53SCk6KZ+qE4Xw/y6lEgUqOnF2YTP0exDn90kk
         TeRw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ3ExaN/4L3U7dC2h8vU3bMf3++eqNLf6Voat65q50bIt4mU/z7hQGcDh1vtBF/43to30q2gkL5mhRTFPBY2Q1Pu/imh3VirIEkbjDOTtG3wAlcxgIt7XLm6N/G4fU+Ob2dFAKyL8deWFkt4JvVQ==
X-Gm-Message-State: AOJu0YybmelCkXgGV4G124xB/GDvrdRS/Dp+n1Aan9jxjMGPTHGL852Q
	wpm1dauRG8BqImGzGJFGfkMoF/Hm+o2jCxg2ra74otCxkId6/t1/
X-Google-Smtp-Source: AGHT+IHaXLkzhWLWiltJv7xtEQ0SXk4PJtfEb85xpaHpPioktaNs0x03plQbbjNWGCkV27c/Kxch0g==
X-Received: by 2002:a50:cddc:0:b0:572:67ee:d3d9 with SMTP id 4fb4d7f45d1cf-5734d5ce8e7mr15049601a12.17.1715954845131;
        Fri, 17 May 2024 07:07:25 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65b5sm12118612a12.6.2024.05.17.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:07:24 -0700 (PDT)
Date: Fri, 17 May 2024 07:06:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf list: Fix the --no-desc option
Message-ID: <ZkdkZfdj4IewIns4@gmail.com>
References: <20240516131544.2885917-1-leitao@debian.org>
 <CAP-5=fUaUGJ-09N-u39YyZgJOnj_WE91-hUc8dv+tf7ozA3K2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUaUGJ-09N-u39YyZgJOnj_WE91-hUc8dv+tf7ozA3K2Q@mail.gmail.com>

On Thu, May 16, 2024 at 01:15:23PM -0700, Ian Rogers wrote:
> On Thu, May 16, 2024 at 6:18 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Currently, the --no-desc option in perf list isn't functioning as
> > intended.
> >
> > This issue arises from the overwriting of struct option->desc with the
> > opposite value of struct option->long_desc. Consequently, whatever
> > parse_options() returns at struct option->desc gets overridden later,
> > rendering the --desc or --no-desc arguments ineffective.
> >
> > To resolve this, set ->desc as true by default and allow parse_options()
> > to adjust it accordingly. This adjustment will fix the --no-desc
> > option while preserving the functionality of the other parameters.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> > Changelog:
> >
> > v3:
> >         * Applied the same logic to default_print_metric() and
> >           json_print_event() functions, as identified by Ian Rogers.
> 
> I don't think we should change the json behavior. We're generating a
> dictionary and the consumer of the dictionary isn't obligated to read
> all of it. I tested the non-json output and it all looks good.

Thanks. Let me remove the json part then, and send a new version.
