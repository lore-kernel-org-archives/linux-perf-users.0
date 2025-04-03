Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300A2505D6;
	Thu,  3 Apr 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693825; cv=none; b=LDOwPLVG0kGytA2AceMewtQSaXL7D0Ml1qFJQuJspmlsngUzfsIiLAHGV8wMOfvIdf/tFElAqaw4GSPalmTedxyv04e+i30aYC2I9izs++rOUfHwDxmzKH5frXOTIY8/K939ETjlMtIg4FQGIq+xdUcqK6SSMb6EbNL0FrO5M8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693825; c=relaxed/simple;
	bh=0rzr3+1EKy2s0lYSqwKrAgJ24jrlfxrDyurHnT3rTjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MryQ+NkAHwaR+Xe29tYbpBeFqT72LI+vMlK/PmmHxPZzoTfsiUtbmwtk+G08JdFh+gO1Lz5gjF2ENHktA5efVYQqo+ejEejIa0BvP8myQgm8MGnnNw9IwnW51o4Ii3Aa4L9JcKTEp2AJLq3G1m39dBzjY/Nxm8Nm69xPPicV2eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is4MODbn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is4MODbn"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3032aa1b764so829962a91.1;
        Thu, 03 Apr 2025 08:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743693823; x=1744298623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rdXwfXpVZ0DoDhTpXcomK86T+y8d/zsLL6G5IX+ENN4=;
        b=is4MODbnqJ+hsJMF2UHBZ7ho+9pmNGZ3GBJDNATGBVzskn99ZW+OLsA16s7zRf15yC
         60bFYIGR6ybMow7IfNT4FXJjabu1sP7BFbbDWal9XQzleOm54OIFhz8OqBrArKZaz1UE
         uJpEq6OzLykGYpT4ddu8xNWZ0drcU9HIEdolSPdrCzF+4/pmZMjcTs6U4B7YlthgFej4
         K06L+hYgnoaEfB+APAmSO7KEB+R3wdfbjf/1Yw1lAWuyWuv8Dr25vGknNZuWzpPwG0BO
         CKEE8QQ+CChNVv0jJxFMdYdCbn/OkxTdypR1oJRkPgU1xllc20UOL68kIb1QWRykkJhb
         vVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743693823; x=1744298623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rdXwfXpVZ0DoDhTpXcomK86T+y8d/zsLL6G5IX+ENN4=;
        b=VoP4RaYgWDgXOtRo6EWWN/b7BvBRHKgGuuTbi/Cqe3QHRwXAbaBnyjFkdGIuqoLBOE
         PylH8DnzwoVzCam+XtT5cRXInIonw6I9UG0BH+VbLSmyq/PcwofypF4c7BCukr0rdUd/
         RI67LareNnpSqYBR/ve0J5FSx7ZFH7v0rkPW0SJFHzPWw6l4K4+r3LV3wWyaqjR0uRU8
         BuhD7ds0RUBSUZy0FYnr9EuspNNnRvEND7j0506YtuqAistHa3VfauWZFSajHjRRDb0p
         wfFL3YDckDF1nITancoDtQ73jH/ML7XFyMgG9y83WGS6t/RFPMR/ah/FJsOBbA3q3coj
         q65g==
X-Forwarded-Encrypted: i=1; AJvYcCVo68Zun7MpjCqjawH5YNaEO+rQaftRxeJQ2HTroEHBG818CtxCv1MRIeI5psT0vBfxc+5lfhXSu/CFW7I=@vger.kernel.org, AJvYcCWYROlh6WUcG1sHFPR4qrufuf7I7pdYJ87QTd39bZb/pnzY9syJXFIYQ9D8+5bc9DRWFfBHDTrJX0UFRlkspAZ3Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZprdn++pvrnxXzGHiDyIm7Lv9lH60/kg51C5K6jfxvHvj7suv
	WLZSqMQDxpBbqUKkN8udDACyC+NICPPmNmLvRuEybyMWjZWBP1am
X-Gm-Gg: ASbGncsBwhC4Kw43Qi+iABHWRuFotSoXXFuZXqAf4jij9RXrFDw8LWxsHWT2+1HLMNx
	wEdPUQu4WwDBlHPUULu2Xe0xBMvTyYlkz5sGg1l78zEQSKGdA2MUJRu0GQ6kmBj4WwUtZV2LbkB
	rOwvzCvZpDMe61g7mm0/XBJcdKkpaBYf6ckVTAWHNxUrfnNUU5AWDLxsoyKMrmtCD3HgAr94TFm
	vXNRyRWNhrSeZOgs9dR/h7xtvY6bgokGdPQFcfk9eMKm8Vam5GXtt78LnxSCom7suOmOyn2WmAw
	maB9zkMu+4VEKR6yfnthXTk7nGyoOaxwDfonQKoxa3qQ
X-Google-Smtp-Source: AGHT+IGgDqNSkiZ/1y0n4ex34i9tdTgxiA1kQ24PuisY0GpK5fEv6qK05oKY6Sj+Y5rZ3NPeA8r9JQ==
X-Received: by 2002:a17:90b:35c2:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-30531fa5fbcmr30989502a91.13.1743693822517;
        Thu, 03 Apr 2025 08:23:42 -0700 (PDT)
Received: from localhost ([216.228.125.129])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30588a30f00sm1638289a91.26.2025.04.03.08.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 08:23:41 -0700 (PDT)
Date: Thu, 3 Apr 2025 11:23:39 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>,
	Ben Gainey <ben.gainey@arm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Eder Zulian <ezulian@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>,
	Dirk Gouders <dirk@gouders.net>, Brian Geffon <bgeffon@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jann Horn <jannh@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Jihong <yangjihong@bytedance.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Graham Woodward <graham.woodward@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao Ge <gehao@kylinos.cn>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Casey Chen <cachen@purestorage.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Li Huafei <lihuafei1@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Andrew Kreimer <algonell@gmail.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>,
	Steve Clevenger <scclevenger@os.amperecomputing.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 02/48] tools headers: Silence -Wshorten-64-to-32
 warnings
Message-ID: <Z-6n-3ObiNNLQzFw@thinkpad>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-3-irogers@google.com>
 <Z-6WY4a6RV1bEbNU@thinkpad>
 <Z-6aoJ3ohVHPsF0A@thinkpad>
 <CAP-5=fU6E1_8Vzki1dVyb8hDEYOXaSNSrJJkR6AOU8xqvknT8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU6E1_8Vzki1dVyb8hDEYOXaSNSrJJkR6AOU8xqvknT8w@mail.gmail.com>

On Thu, Apr 03, 2025 at 07:52:45AM -0700, Ian Rogers wrote:
> On Thu, Apr 3, 2025 at 7:26 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > On Thu, Apr 03, 2025 at 10:08:39AM -0400, Yury Norov wrote:
> > > On Tue, Apr 01, 2025 at 11:23:00AM -0700, Ian Rogers wrote:
> > > > The clang warning -Wshorten-64-to-32 can be useful to catch
> > > > inadvertent truncation. In some instances this truncation can lead to
> > > > changing the sign of a result, for example, truncation to return an
> > > > int to fit a sort routine. Silence the warning by making the implicit
> > > > truncation explicit.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > I'm the first person in the To list, but only a couple patches in the
> > series are related to my area. If you want to move it with me, can you
> > send bitmaps, bitfields etc. separately?
> 
> Hi Yury,
> 
> If you think it is worthwhile. I did the series to see how prevalent a
> bug was in perf's code - inspired by Leo Yan fixing an instance of it.
> I would prefer not to be on the hook for all the kernel warnings :-)
> Perhaps casts to avoid changing bitmap_weight's type. Unfortunately to
> get to where the perf issues were I needed to clean up header files.
> In the bitmap cases the change is just to make implicit casts explicit
> and I don't know how much value you see in that.

Your changes  are technically correct (except for non-synced kernel and
tools), make the code cleaner, at least to me, and address pretty valid
compiler's concerns. To me, it's worth to apply.

Thanks,
Yury
