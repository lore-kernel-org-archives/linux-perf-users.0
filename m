Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1051AAE27;
	Mon,  4 Nov 2024 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758184; cv=none; b=aQ4Kf9d0J0m8Uj0muqv+ymyT1/tubA1qTE2PqUZzvSj6BX7J5n4Gtzp+iVFtdpGvlXTxxXoNAklCRG+FlPn1J4o1Kng3iIMU4Y06sygQ6SvbrzuVM3BLQkcGySrt+rwq7PY/o5+MI4cpT1PjLt3TvRsEX2EbRlxzAyzvytlp2pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758184; c=relaxed/simple;
	bh=Hd/GX4rs/QFp7jmf45XPlXgJZu+CdI3P4iDkuE5QVMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwMWp/slQjEeFVGBiYTideBiaUQF95dZlxrdGfPNJ2ibsf8qplXc3DTAxxvpov1sOrDSZT6e8FLVcFmY2GeAn6cd19HBnGatbReCLlMcKWhiUYkvG07cCe6SUD7NV1H6fkJVnwQN87rz71iIQSCIP+ev4KzaH/GzYKaCPmjRTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfRF+nbt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfRF+nbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0026BC4CECE;
	Mon,  4 Nov 2024 22:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730758183;
	bh=Hd/GX4rs/QFp7jmf45XPlXgJZu+CdI3P4iDkuE5QVMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfRF+nbt5tPvE+BClZDGgRrksornQrxb8nU0LGUXjEB8funSyWG7zYErrKnhfY/mt
	 MxhJZdKEnfmejkxjkP3x6sEB+EMJomO2Okcb6+W9YkrvQ4ayRf9RQ3ikiRl6ARIZ5/
	 W4XMq9rcP+TFyu6e8VuQnpCPJZyBZugwULMmDSED4SxORju4o7S7EGsF66baqqgJzy
	 iCkQBFtq5lj341w9qhdpqzhOHY9t7RgXENemJ2S6zmxFjXcnh7cTB2CpAueAInrCIz
	 +aLPNAe/xVKraFeMdMcZs0SBzdDs6NKn+iHuzvmIKZf3sLO8m6AIBNVeSwzDAsr3GH
	 Usd/9JbHMShJA==
Date: Mon, 4 Nov 2024 14:09:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v5 06/21] perf script: Move find_scripts to
 browser/scripts.c
Message-ID: <ZylGJF7Ux3JdJllo@google.com>
References: <20241031014252.753588-1-irogers@google.com>
 <20241031014252.753588-7-irogers@google.com>
 <ZyPX7ayIO4teziDX@x1>
 <CAP-5=fVgJu8BJWFVUkCy1Zsi3piTPdV-GXL1bTpWZeO=nm=jrg@mail.gmail.com>
 <Zykk2MJ4REGCaqVw@google.com>
 <CAP-5=fXQpej43wxEtMYFbxdofHtUi98X68W4AaR9UCfsbDir5A@mail.gmail.com>
 <ZykxD41c6gWQoIrQ@x1>
 <CAP-5=fWf8guTgqwfrrct3AGYDC=Lb1Oxo7kXU_x1yEr5urFSkQ@mail.gmail.com>
 <Zyk19KgzI7ybPkQ4@google.com>
 <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXj1-wqt+Bs-0ZypRsaZw2VP0qyKdeeRHpjUD5BwO9OBg@mail.gmail.com>

On Mon, Nov 04, 2024 at 01:06:35PM -0800, Ian Rogers wrote:
> On Mon, Nov 4, 2024 at 1:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Nov 04, 2024 at 12:48:01PM -0800, Ian Rogers wrote:
> > > Namhyung was asking that the c&p of code be 1 patch then "add new
> > > changes like using openat() on top". That is:
> > >
> > > patch 1: add is_directory_at - introduce the 2 line helper function
> > > patch 2: move the code
> > > patch 3: update the code to use is_directory_at
> > >
> > > patch 2 is known broken as patch 3 is fixing it.
> > >
> > > Hopefully this is clear.
> >
> > Actually I don't care about the patch ordering.  My request is not
> > to break build and just to separate different changes out. :)
> 
> So, patch 2 can't be separated from patch 3 - are we agreed? So we
> squash patch 2 with patch 3. Patch 1 is trivial and fails to meet the
> bar of a meaningful change, so we squash that. We end up with this
> patch. If there's a later revert and a dependence of the 2 liner, just
> don't revert that part of the change. We've never had such a revert so
> it is hard to see why we need to generate so much churn because of it.

As I said the patch 1 should be the c&p and no need to introduce
is_directory_at() before that.  Why not doing

 patch1: move the code
 patch2: add and use is_directory_at() + openat()

?

Thanks,
Namhyung

