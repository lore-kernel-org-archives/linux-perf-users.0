Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BA513AD11
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Oct 2024 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730134881; cv=none; b=l/fEFmA5rtDVFQLHT5YJdDzpRLhs+txtDtm1+W5bismp0IdsGq5jTpH272T7NaOAYnr/DhYFUt++Qk6kDdiUj10tdCQsfCKBe90YWUXmNkMsVUS/KITzEsHaXWx0vEamKZmnsV9GStTTnTNVVMiXJ14omz95Dso6lXX1rO8mLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730134881; c=relaxed/simple;
	bh=kdGCNGPFrHbBc21gfZLuHiW9sHHvBjXh5uK9c2elIgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHR9vcuSpik1uhEfE0f3utOaC9rrO+5gWrY8T4vnfq8AkLPUiStChNz/IOTCqWCVUROIUmHbK7/TX/tcMvD7JJU80hAE+sb1BFNo8wpmqVPoADe7J9GUXwKBxh8bPLJGytjnkJyVcpSNoPK5POXYDBnvSpbzqpx9brPxxxqxoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkbNb8iJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkbNb8iJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1047C4CEC3;
	Mon, 28 Oct 2024 17:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730134881;
	bh=kdGCNGPFrHbBc21gfZLuHiW9sHHvBjXh5uK9c2elIgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkbNb8iJmYkNl59w/brnZYB2wo0HfgSPOsgkZrmSasdz2MHcB1CHoMv32bvF7aehU
	 Ycv0jXIng7cUWqR5dM6mApJcW5/88zNO2p9Vck18l9brBRYlSNYebVTeZXxMm9Bdi3
	 B5tFJhSfSQEc5kZ+H13M9Px4/jghSMAHIWkT9a9YImrXewjcbM+aJTYVa1P+S7bZFe
	 T95jA2qjw9V78+iP7LfOEJWv1b8F7LdqJ3eQtMzvI65lgmqExV5RLbLcIuV+YKByw3
	 Pdnd0Y83eN/S/MkGlTQ58P3WfH8nntoYE0DUxgpixdy7ISsbDcTnuzhFTgMIcIKqeh
	 modWptDPzi40w==
Date: Mon, 28 Oct 2024 18:01:18 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: Can perf drop libunwind support
Message-ID: <Zx_DXt3ESi394mcx@localhost.localdomain>
References: <CAP-5=fUXkp-d7gkzX4eF+nbjb2978dZsiHZ9abGHN=BN1qAcbg@mail.gmail.com>
 <Zx-1tx0eH19iBpjy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zx-1tx0eH19iBpjy@x1>

Le Mon, Oct 28, 2024 at 01:03:03PM -0300, Arnaldo Carvalho de Melo a écrit :
> On Wed, Oct 23, 2024 at 02:57:05PM -0700, Ian Rogers wrote:
> > Hi,
> > 
> > perf wants to build with BPF support these days. libbpf has a
> > dependency on libelf, part of elfutils. libdw is also part of elfutils
> > and amongst other things provides unwinding support. My understanding
> > is libdw unwinding is used by perf in preference to libunwind when
> > present. My suspicion is that libunwind is being feature tested,
> > linked against but then seldom or never used. Given this could perf
> > drop libunwind support in order to simplify the code base?
> 
> Probably Jiri remembers the reasons for us to have support for both,
> IIRC libunwind was a bit more mature at the time and so we decided to
> have both and when some broken behaviour appears we try the other one,
> in the process trying to fix the one wioth a problem?
> 
> Adding Frederic as well, this is when we started to use libunwind:

Ouch, memories are blurry... It's possible that libdw deprecated
libunwind at some point. I'm sorry I completely lost track of these
things since then :-s

thanks.
