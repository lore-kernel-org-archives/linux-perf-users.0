Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83791A2C27;
	Tue, 13 Aug 2024 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573663; cv=none; b=K7ptPLY9E3vNwWNzAPFDxl0DwXIgkIpYmLdZTwynt/2kEyN0z2g5T+o6sYfFvfYaHfWgiuBVBW1PQq2bvfb7/jl4UvriUccvAe3WeBSQHOdZYoBWUciYPZao1EvNeDO5c0XUbkcLyt1/SDtPl52hCvAKMKUjx+0d2br7X4cYcCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573663; c=relaxed/simple;
	bh=fYKETN0ue5J6jFSSC2xMfeoJPHJbnH37wBF/DAF1Lxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rg2QAZHTS/GjMLPlV4YGa9Rdn5E2v+ql/jkXr8T6hjLckoLklGQvgtD6dmjoHn3aaXkFYYeij7gBHnIi957b6Yo3YTAociKo3rtfmm+nemw/mW/Zbu8nL72BCGSANTNZt3jbUjWVqcXctyyD1lw2fuOR0pOAB4swTvMZkFgSC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH+A0fmG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH+A0fmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE55C32782;
	Tue, 13 Aug 2024 18:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723573663;
	bh=fYKETN0ue5J6jFSSC2xMfeoJPHJbnH37wBF/DAF1Lxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HH+A0fmGo6FLh34/bP9e9Z32XNQGGSxvI+H/KKZYHujw8pWxGzoIknR2ZzQe7aZp4
	 po7LNuV8wcoRsSbwcMUyQmI0jm43W8rRaZEJPKnHqYWBdHrbVEtwuU0OurIcCHNiEu
	 yVclUB4Q88iBPAI0eJauWXlNiQYB5hiesGLzwYx3pH9ItbFJ7xAIEwh9eb+Kigfdxu
	 ncigJgHUBGxGJvM44ey3Kgz6umYF8qVu17K+jShNT4x9rS48LF4++WVV12/RKzcbrL
	 yoqLQQUPDFDmZ97rmLazc2MpHI1C2QmsWfh7phQ+6cNHjg+A7AzHG6Hqoz8JF3nlYR
	 Vfttpl1GMngoA==
Date: Tue, 13 Aug 2024 15:27:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Wang, Weilin" <weilin.wang@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"Hunter, Adrian" <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 8/8] perf test: Add test for Intel TPEBS counting
 mode
Message-ID: <Zrulm_giiqaFP1li@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-9-weilin.wang@intel.com>
 <Zrq11fq_F9vImsQh@x1>
 <Zrq2IoAgopw1NbbA@x1>
 <CO6PR11MB5635B87159218287A4E8108CEE862@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAP-5=fX9pLRig7qJ+6Wk1g9ysDUDDKXMbo4s1GYvz28iAPs1iA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX9pLRig7qJ+6Wk1g9ysDUDDKXMbo4s1GYvz28iAPs1iA@mail.gmail.com>

On Tue, Aug 13, 2024 at 10:48:21AM -0700, Ian Rogers wrote:
> On Tue, Aug 13, 2024 at 10:18 AM Wang, Weilin <weilin.wang@intel.com> wrote:
> > I just checkout the code and tested it. The failure is caused by a seg fault on a
> > perf_tool struct that is not initialized correctly. I think this is related to the patches
> > on struct perf_tool in this branch that applied right before the tpebs patches.

> > I was able to fix the seg fault by adding the perf_tool__fill_defaults() back. Since
> > Ian updated the code to replace this function, I think I need some advice on how
> > to use the new code to initialize perf_tool correctly here. Should I call the
> > perf_tool__init()?
 
> Yep. If you've added or refactored a tool struct the intent now is
> that you call perf_tool__init then override the functions you want to
> override. I don't mind to rebase those changes over your changes,
> Arnaldo if you want to drop those changes.

So I'm adding the patch below, which should be enough, right?

Now:

root@x1:~# perf test tpebs
123: test Intel TPEBS counting mode                                  : Ok
root@x1:~# set -o vi
root@x1:~# perf test tpebs
123: test Intel TPEBS counting mode                                  : Ok
root@x1:~# perf test -v tpebs
123: test Intel TPEBS counting mode                                  : Ok
root@x1:~# perf test -vvv tpebs
123: test Intel TPEBS counting mode:
--- start ---
test child forked, pid 16603
Testing without --record-tpebs
Testing with --record-tpebs
---- end(0) ----
123: test Intel TPEBS counting mode                                  : Ok
root@x1:~#

diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 3729caeba645a3e8..50a3c3e0716065f8 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -164,11 +164,12 @@ static void *__sample_reader(void *arg)
 		.path = PERF_DATA,
 		.file.fd = child->out,
 	};
-	struct perf_tool tool = {
-		.sample = process_sample_event,
-		.feature = process_feature_event,
-		.attr = perf_event__process_attr,
-	};
+	struct perf_tool tool;
+
+	perf_tool__init(&tool, /*ordered_events=*/false);
+	tool.sample = process_sample_event;
+	tool.feature = process_feature_event;
+	tool.attr = perf_event__process_attr;
 
 	session = perf_session__new(&data, &tool);
 	if (IS_ERR(session))

Thanks for root causing, my mistake,

- Arnaldo
