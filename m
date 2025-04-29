Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C91F416A;
	Tue, 29 Apr 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745920422; cv=none; b=isuIE1WMVnMXm7GdwWuiOMUBTc/PvKdiBMyEYAwupjtxXpR3CJQv9HPLX9hJ27wOV7IS6b00tNYJ9VGS7x+aaJrbyaUt28LQSnYl7qGiK0b+OC0cGwTumOxK73wzsALDfQcZyMCsR6jksnRwy+BiYpNDotwpIRa5xJtRVJXpSNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745920422; c=relaxed/simple;
	bh=OhGV0jZlvwbTl/ALDvHmL48asVDhok2hLypoi47b+h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYtlqqYeS+CSyVGtRx+RYTYz5pN1SmuduAsh/s0n93ssxKUJzwd9qfGI0BBnQnjskj94KqRLyd8kIjSvbGPDVkSLAdH4MjPYHELjIjGd0YgUYYkzBc4Ji2ABtUOAUS1bLV6Hfd14I7VJYgK5cT0WHFmgwZ0GInrTDQs0V0d9IT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3860E1516;
	Tue, 29 Apr 2025 02:53:33 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EBBE3F66E;
	Tue, 29 Apr 2025 02:53:39 -0700 (PDT)
Date: Tue, 29 Apr 2025 10:53:35 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Namhyung Kim <namhyung@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Subject: Re: [PATCH v1 09/48] perf tests: Silence -Wshorten-64-to-32 warnings
Message-ID: <20250429095335.GH551819@e132581.arm.com>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-10-irogers@google.com>
 <20250402143541.GM115840@e132581.arm.com>
 <CAP-5=fVqax8cxdZ4HLBP4AMxL6jADfYNrORC97T6F23mjf3N1w@mail.gmail.com>
 <20250402163807.GP115840@e132581.arm.com>
 <CAP-5=fVJkJ39_qx2T9ZHn-fdxjECP_2G+cyfRRAjLvZZt5vz2A@mail.gmail.com>
 <Z-4URXOzsVHTY7zz@google.com>
 <CAP-5=fXwAA0PNYAOLNLdHY8g+AyEB0UxmzgX5w-gGj_DZqUxtg@mail.gmail.com>
 <20250428111003.GC551819@e132581.arm.com>
 <CAP-5=fX3jn=ff9itMemKB22ACnHtU_cO6YUcx=uYYWX4=QaLJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fX3jn=ff9itMemKB22ACnHtU_cO6YUcx=uYYWX4=QaLJw@mail.gmail.com>

Hi Ian,

On Mon, Apr 28, 2025 at 09:29:37AM -0700, Ian Rogers wrote:

[...]

> Hi Leo,
> 
> So I sent out cleaning up the kernel headers separately:
> https://lore.kernel.org/lkml/20250403165702.396388-1-irogers@google.com/
> Arnd commented that it would be nicer to do larger changes, but my
> concern was breaking printf modifiers, etc. It looks like those
> patches have lost momentum, not sure what's going to happen about them
> being merged.
> 
> On the fixes vs refactoring. I'm not sure refactoring is the right
> term for the other things in the series. It is basically trying to
> make implicit casts explicit, without doing some boil the ocean
> exercise.

Yeah, I agreed that some "refactoring" is actually fixing bugs.

> I went through the issues in the email this is a reply to:
> https://lore.kernel.org/lkml/CAP-5=fXwAA0PNYAOLNLdHY8g+AyEB0UxmzgX5w-gGj_DZqUxtg@mail.gmail.com/
> Do you want to send the bits you think need prioritizing to the list?

For me, at least two things can be fixed first:

- One is the test case switch-tracking.c is broken on Arm64, your
  change for the compar() function would be fine for me.

- You mentioned the issue in ui/hist.c:
  ret = b->callchain->max_depth - a->callchain->max_depth;

These two issues are similiar and can fixed in the same format.

> > > There are lots of cases like:
> > > ```
> > >                 case ARM_SPE_COUNTER:
> > >                        if (idx == SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
> > > -                               decoder->record.latency = payload;
> > > +                               decoder->record.latency = (u32)payload;
> >
> > This would be fine.  Since Arm SPE implements a counter with a maximum
> > of 16 bits, there will never be an overflow when storing the data in a
> > 32-bit unsigned integer.
> 
> The payload was > sizeof(u32), should record.latency be a u16?

Yes, we can change to u16 type for latency.

> My point wasn't so much to complain about adding a u32 cast in the SPE
> code, but that having the cast makes it clear that truncation is
> expected. Adding the casts isn't fixing a bug, but it is making it
> clearer that the code will truncate the payload value (imo).

As Arm SPE has defined the format, I would prefer to refine the code
based on the format:

  #define SPE_CNT_PKT_COUNT(v)    ((v) & GENMASK_ULL(15, 0))

  decoder->record.latency = SPE_CNT_PKT_COUNT(payload);

I can send a minor patch series for this, if not conflict with your
side.

Thanks,
Leo
