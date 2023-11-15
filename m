Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE5F3174F
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Nov 2023 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDFJiS8X"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E653AD;
	Wed, 15 Nov 2023 08:13:36 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-778927f2dd3so365805585a.2;
        Wed, 15 Nov 2023 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700064815; x=1700669615; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4l2S5IU2Yw8qLrFVo0w/N0DBaTHJYaMr800eANEyqg=;
        b=mDFJiS8XIXXEC+YI4mW5jHWK3yJrQ7ErWnxcepiJo1zfRCMGOLlVAfQzz2lVZOvECy
         cUljMiOYQkSQPktGJkP4pEgpZ6dB66f/meIOv96CVjQgUzVDjchFh7UdeHVTESNuvG1Q
         Tun2m/H0uBW429HfDe6rUwAPZUfINOxBcIxvkM1JQEuysmipruvqdrKGdvS/12Ijjf+F
         P5J6ePit6xm0X7FY8dbyzfyjuorT9Y+ppU2SqgD7t1DHkO/tBythu9gBqTn2NxpIJfwn
         JeEn528YarMAvANYt57iKbX8iN+xYra+1NACZTuXYsA24pizVSM9NDP6RvWeSUuBVFtj
         0YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064815; x=1700669615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4l2S5IU2Yw8qLrFVo0w/N0DBaTHJYaMr800eANEyqg=;
        b=YrRB/UZTUvAsXgxfr0OdFgdxVZ+mn1u9z50vQlUBS2/Q6pkwEoXyWaZUWDppDQfZII
         qzscwfWPKazaZwLN+5V+jr4CAkC4PnECUkQLfgBxSDym4/47u8eytuxgs3vRr2YBpG9q
         O53NXlm5zlZ7ZBWXLod737ESFPrQMFkD/Y+TKB0lr2jKNYYD++rXAwUHypIlISeWOg44
         n1FhNjkIJ4J1Y3ene/VPicaOWcPxWs5bH+QxGHTekkkxYYnzXdIsBkHPfevdZjrVVfpU
         rVEZrAKX9+KlLJTAfjd8Bw0/5gbUgHQ0CholvRKMuyglrm2uXbmOdAcXpn6ZyjJ8hRcJ
         YCxg==
X-Gm-Message-State: AOJu0YzcZatmD8nM/mcOxHJNhZN6ds2e3KokKRA8xJj5VXMpyskWZw6M
	HI8bw8jFt2hlCyrRvSzxaso=
X-Google-Smtp-Source: AGHT+IGtw3Ve5XJ0wDd2OznzHFIjYM2SvIb/peNumSCl4D0lS935XS7P4JTGg/fyqOqJrRgzrBRFOw==
X-Received: by 2002:a05:6214:5c7:b0:671:567d:b13c with SMTP id t7-20020a05621405c700b00671567db13cmr4995854qvz.63.1700064815082;
        Wed, 15 Nov 2023 08:13:35 -0800 (PST)
Received: from google.com ([2607:fb91:ecf:35fc:41f6:151:da39:2a3])
        by smtp.gmail.com with ESMTPSA id l18-20020a0ce852000000b0066e0c924109sm631858qvo.106.2023.11.15.08.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 08:13:34 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
Date: Wed, 15 Nov 2023 08:13:31 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <ZVTuK5VRQfY1JOEY@google.com>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>

On Mon, Nov 13, 2023 at 08:56:39AM -0800, Namhyung Kim wrote:
> On Sat, Nov 11, 2023 at 10:49 AM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> >
> > On Fri, Nov 10, 2023 at 10:57:58PM -0800, Namhyung Kim wrote:
> > > Anyway I'm not sure it can support these additional samples for
> > > deferred callchains without breaking the existing perf tools.
> > > Anyway it doesn't know PERF_CONTEXT_USER_DEFERRED at least.
> > > I think this should be controlled by a new feature bit in the
> > > perf_event_attr.
> > >
> > > Then we might add a breaking change to have a special
> > > sample record for the deferred callchains and sample ID only.
> >
> > Sounds like a good idea.  I'll need to study the code to figure out how
> > to do that on the perf tool side.  Or would you care to write a patch?
> 
> Sure, I'd be happy to write one.

I think we can start with something like the below.
The sample id (attr.sample_type) should have
IDENTIFIER | TID | TIME to enable defer_callchain
in order to match sample and callchain records.

Thanks,
Namhyung


---8<---
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 39c6a250dd1b..a3765ff59798 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -456,7 +456,8 @@ struct perf_event_attr {
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
 				sigtrap        :  1, /* send synchronous SIGTRAP on event */
-				__reserved_1   : 26;
+				defer_callchain:  1, /* generate DEFERRED_CALLCHAINS records for userspace */
+				__reserved_1   : 25;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1207,6 +1208,20 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
 
+	/*
+	 * Deferred user stack callchains (for SFrame).  Previous samples would
+	 * have kernel callchains only and they need to be stitched with this
+	 * to make full callchains.
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *	u64				nr;
+	 *	u64				ips[nr];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_DEFERRED_CALLCHAINS		= 22,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
