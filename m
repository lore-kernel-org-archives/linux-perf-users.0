Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B93A23D297;
	Thu, 18 Jun 2026 21:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781819866; cv=none; b=gIaYMfECMV2VcBe90zD5+EF7JHK3wiRNr0MATBkuUz5w45eq5mRJib1j+xzrGm9iaRfGuC6e/cAhs1C0aZZ3UHg4XGRgk4aDdzWARqsYTQ83JZaNXyXuyL1KStHa6YQfcI850FOW6ZOj/cQ32gwvPUZ4Mf+aqpBLCvuj9ELQaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781819866; c=relaxed/simple;
	bh=EHb2mpJJXglq1mh0QL3PjyAeumX0h95t1YUzrYYTByY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANIQo+lfY5099alXylt1swfskouB/eVwACddNOpE6SDsylWAmQtS/qCpf4gw6rWEAIzRemT2cLDKBP9nM7kyPUt0rT2v8Iaynz9NMDpl4kFmpyZNv5HBx2tYQKfYg9whzRJXgADy8FyFPXtrq+2CsjH8WP8NzDirIKPtPF+KELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxNe6vJ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxNe6vJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D86D1F000E9;
	Thu, 18 Jun 2026 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781819864;
	bh=/RdHHlnsL8iEw8sYUD3kbfA/kf0r5UzEvLYytlbscW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LxNe6vJ9mckz9Kp9w3wxYcZ8XFILQfiNCzfraEmnGNv/ga9BRJYRIQkzeM3DqqoT/
	 WHZm3980kzUf4jmZp32A15y/HNgUwrtGUdt3aZsFwnZeQyERX1+knPx39f7qj4k+7Y
	 9C2Ri9mEIxlzNXAaVsXDro7H2Fcb6M2JUJP9VL0wrBXCESP8eyKCNAcpi5RvWNCQxb
	 RmHXtfwaYQ3DC40RyN1/Ys6ABveUbeCX7vWg42bR9S7wYLanDeosYP/6JZ5On0IAwM
	 CRMrOtjXamiKDPqAozOatMNMF/GIcjW8sDNiJaGq4NA2Czl1swd2V90N7oDMlu3YfP
	 sc4/DsP+UOtoQ==
Date: Thu, 18 Jun 2026 14:57:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES v2 0/7] Initial support for some Rust tags + way to ask
 for CU merging at load time
Message-ID: <ajRp1wLpUi9vfaYG@google.com>
References: <20260618151606.82747-1-acme@kernel.org>
 <ajQrjKyBjjR1vxp6@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajQrjKyBjjR1vxp6@x1>

On Thu, Jun 18, 2026 at 02:31:56PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 18, 2026 at 12:15:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > Hi,
> > 
> >         Here is a series with some initial support for some Rust DWARF
> > tags and a way to ask for CUs to be merged just like we do for LTO to
> > cope with inter CU tag references.
> 
> Sorry Namhyung, used the wrong send mail script :-\ This one should have
> been sent to the pahole mailing list, doing that now.

No problem, glad to see you are active on other projects. :)

Thanks,
Namhyung
