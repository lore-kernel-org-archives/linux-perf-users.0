Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DA72E62D8;
	Thu,  3 Jul 2025 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751566731; cv=none; b=h3I/diZ+MktzwrlBTUjBIXPXHN+QbfxW/H2+QL5aoPPbLk2toDfnXdA2pvcM6+tJEokTr57njhgnTYIXt2lCSd5G0JLQcoXz8PBZ3dh5K+0dIx0CPGzvtsO6ObwsBz7OIwOEpIna7GXHEgvLG9eiAn4mMXdshVtDwLmOn+wziSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751566731; c=relaxed/simple;
	bh=YtFOwhZrPGivqU0Tqz0yuzRP+19G1n+XMW2/iidYBCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ba3SQNXTjG5jEp6OKBsDv4K1Ogi0ZLNhCsA9iV1q+GazOSqel1Igp7jBp3lNzWURUp/gJDXE6p8DD6GbtmJ01WVRJ5gzIu9fOf2g+OtBJsLZk/iEKnbSugD2V8Wc4RFggXd8jxiEfPq+ZtN6BgXjw4mRlVM91EPBSC4p0goQRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDe9ywVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDe9ywVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EF6C4CEE3;
	Thu,  3 Jul 2025 18:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751566730;
	bh=YtFOwhZrPGivqU0Tqz0yuzRP+19G1n+XMW2/iidYBCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDe9ywVHnoUjJJqBxeRTTtA2aWotCcgZN3vFh6rF/45Th9Boi+H6d5XYiYtcqO4kW
	 9VbCVKp0m1/nQE0RrhPNLRgD/0K6bt1+w6ifxFEY2lMD/SMlLK0pI23q+GZbDyBXYw
	 Z+6WRrRtdrAFFWXVR/TxYSF0GAXTrgZi9E0DyePG8dHuU2wIIvDe3MWvclLAvN1yGr
	 olLn/awScAMeH0JhVS5XR254u+KtSK0ADBazXOW3CnobESY8AJ3iJUg6qtiSvRl2TM
	 90ztEgw9ebUSGdvnd7vdtEH1wJB0Ktn+ykc+IrWc7QnQR18J26YXCk4djJ1jrKgExE
	 c4yqn4ZiGnmDA==
Date: Thu, 3 Jul 2025 11:18:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf test: Sanity check file descriptors are
 cleaned up
Message-ID: <aGbJh-hGwzV6OJwO@google.com>
References: <20250624190326.2038704-1-irogers@google.com>
 <aGXo7Hp31qZOTx9S@google.com>
 <CAP-5=fV4mSjxJBSScYu1XFqFMMT0vO+jJDwq57kUB+cEkxQqMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV4mSjxJBSScYu1XFqFMMT0vO+jJDwq57kUB+cEkxQqMQ@mail.gmail.com>

On Wed, Jul 02, 2025 at 08:03:08PM -0700, Ian Rogers wrote:
> On Wed, Jul 2, 2025 at 7:20 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Tue, Jun 24, 2025 at 12:03:20PM -0700, Ian Rogers wrote:
> > > Some recent patches showed we were leaking file descriptors:
> > > https://lore.kernel.org/lkml/20250617223356.2752099-2-irogers@google.com/
> > >
> > > When a test is forked the file descriptors >3 can be closed and then
> > > any file descriptors >3 left after the test are leaks. Add this
> > > checking to the forked test code. Prior to that clean up some file
> > > descriptor usage so we can assert that only file descriptors are
> > > cleaned up. Sometimes the file descriptor being held open is the
> > > result of a memory leak, so fix those.
> >
> > Interesting, I can see a few more tests are failing with this.  But we
> > can figure it out later.
> 
> That's cool. I was a little disappointed that just the dso kcore leak
> was found by this. I was also surprised that the dso kcore memory leak
> hadn't shown up with leak sanitizer and reference count checking. Let
> me know if there is anything more I need to do to the patch series.

Applied to perf-tools-next, thanks!

Best Regards,
Namhyung

