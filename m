Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287ACA64;
	Thu,  3 Apr 2025 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656010; cv=none; b=Esxnz9ABar/09zNNhPI5ticu3Gj7Urvuaeg0J7LnIPX9boyyRG9GuY7attTVb5RCMI6Y2OQxoOBHAYIrlS42u2fnP4G2BgMMvIa/+h+ziCDqCPKhTScBH+IkGWFZ+ghRaNpwiR0EzDv6byzbwAQQ8uINLSLpybsRl7vemZw07ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656010; c=relaxed/simple;
	bh=HBlgT8HObyk8EukKhLMvzWEvUxYyimaN545pPqCp4oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7I4QBSGAHHTTdfC1G4roRD9/MzY9zRMVUzoZNINTySLcoL6jWv3N5LBsHJhcwz6JepUvFmkmwz+WsCt11gh1zSh69fayHhspcIRlI+Ipa070UQrp0PrP54JYXOAuGlsAYrumeykFPoF8cZ+Xd/ayXr47jmoBwMlSmqT21wr6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEchQTpJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEchQTpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE9FC4CEE3;
	Thu,  3 Apr 2025 04:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743656010;
	bh=HBlgT8HObyk8EukKhLMvzWEvUxYyimaN545pPqCp4oA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEchQTpJUyIdwpaTGznS1u7IIwZjR9qQHnzXHP4YoAADNqnxG++Lct79rpjdpvs6g
	 chI7km80K6itmez01MCUz9kzljTCbpdQ/oDaekm9NpnDDPjfpNVmoG0ZQyTWXwKTtz
	 48tvYm1yY8SEtEwBQ1V0efTtVlqc2dD+oQ0wKrZ6BoE7lXc7wg1udzqWxvWpTgEJ/4
	 6ePXe+qPtCx3Vs4SDpCwfu0Vt4LsoC/S2a1VeEdSoDDYwo3uT86tbLCMUwSwQ+9fe1
	 JEpL3ZnARNJRrWrajS8tbYfspojHF3BBSuL8E6Lp4gKapZoAPUKiQdTlDIpPwhpidR
	 AMQgHVXMuJNpQ==
Date: Wed, 2 Apr 2025 21:53:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Yury Norov <yury.norov@gmail.com>,
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
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
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
Subject: Re: [PATCH v1 09/48] perf tests: Silence -Wshorten-64-to-32 warnings
Message-ID: <Z-4URXOzsVHTY7zz@google.com>
References: <20250401182347.3422199-1-irogers@google.com>
 <20250401182347.3422199-10-irogers@google.com>
 <20250402143541.GM115840@e132581.arm.com>
 <CAP-5=fVqax8cxdZ4HLBP4AMxL6jADfYNrORC97T6F23mjf3N1w@mail.gmail.com>
 <20250402163807.GP115840@e132581.arm.com>
 <CAP-5=fVJkJ39_qx2T9ZHn-fdxjECP_2G+cyfRRAjLvZZt5vz2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVJkJ39_qx2T9ZHn-fdxjECP_2G+cyfRRAjLvZZt5vz2A@mail.gmail.com>

On Wed, Apr 02, 2025 at 09:53:57AM -0700, Ian Rogers wrote:
> On Wed, Apr 2, 2025 at 9:38 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Hi Ian,
> >
> > On Wed, Apr 02, 2025 at 08:42:58AM -0700, Ian Rogers wrote:
> >
> > [...]
> >
> > > On Wed, Apr 2, 2025 at 7:35 AM Leo Yan <leo.yan@arm.com> wrote:
> > > >
> > > > On Tue, Apr 01, 2025 at 11:23:07AM -0700, Ian Rogers wrote:
> > > >
> > > > [...]
> > > >
> > > > > @@ -478,13 +478,14 @@ static int __cmd_test(struct test_suite **suites, int argc, const char *argv[],
> > > > >       int err = 0;
> > > > >
> > > > >       for (struct test_suite **t = suites; *t; t++) {
> > > > > -             int i, len = strlen(test_description(*t, -1));
> > > > > +             int i;
> > > > > +             int len = (int)strlen(test_description(*t, -1));
> > > >
> > > > Thanks for huge polish.
> > > >
> > > > Just a concern from me.  Throughout this patch, the methodology is not
> > > > consistent.  Some changes update variable types which is fine for me.
> > > >
> > > > But the case above it simply cast size_t to int.  Should we update the
> > > > variable type as 'size_t' at here?
> > >
> > > Thanks Leo, I played around with it, but don't mind if someone wants
> > > to do it a different way. I was trying to make the changes minimal.
> > > The problem typically with size_t is we then use the value, for
> > > example, as a printf size modifier and need to introduce lots of casts
> > > back to being an int.
> >
> > This conclusion is not quite right, see:
> > https://stackoverflow.com/questions/2524611/how-can-one-print-a-size-t-variable-portably-using-the-printf-family
> >
> > > When this isn't too great I've done it, but in
> > > this case I think keeping the int, the lack of casts but a cast here
> > > to capture that we expect test descriptions to fit in the size of an
> > > int is the least worst option.
> >
> > I would say in another way.  After we enabled a compiler warning
> > option, this will give us a chance to improve code by dismissing
> > the warnings (and avoid potential bugs).
> >
> > If we use casts just to silence warnings, we also lose the opportunity
> > to improve code quality.  The changes in this series that fix type
> > mismatches are good, but I think the use of casts is not particularly
> > helpful - we're simply switching from implicit compiler casts to
> > explicit ones.
> 
> Right, but I think changing function parameters, return types would
> turn into an epic refactor and the patch series is already unwieldy.

Yep, it's important to reduce the number and the size of patches from
the reviewer's pespective. :)


> With the casts we can see the behavior is deliberate but that's not to
> say it couldn't be better. With the warnings gone it allows
> -Wshorten-64-to-32 to find the truly errant 64 to 32 bit implicit

Do we want to enable this warning?  Is it only available on clang?


> casts. Anyway, I don't have time to do such a larger refactor so
> somebody else is going to need to pick that up. I did refactor the
> cases where I thought it mattered more, but as you say that does lead
> to a feeling of inconsistency in the series.

I'm curious there are any actual errorenous cases other than the return
type of comparisons from Leo.

Thnaks,
Namhyung

