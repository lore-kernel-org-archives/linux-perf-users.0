Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368729B8D3;
	Wed, 20 May 2026 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294666; cv=none; b=sPYxOZX4gNSHsIxmS+9dZukujD5WT70QELUyprFpXqEmIEs+aRnmCUlZbXV8LtiRQe5NIekEsCLCUOhqzJcCWZAFTJuJ/AEqLWWPZQA57i2n0GzmMC1KYq9nBRpj2drk7T6W8dvMU8JI0AQLQr427wr7Eq70PQnDwTy18h0HbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294666; c=relaxed/simple;
	bh=DFBbrIMssZgDRyOev/Us9CTVOOHNvDY1K6rXMTQKj6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMAo/Ckf8LR8+qNwXR6Wuj85FUzjL0o9+z6p536e1pruqLJAHgx1acE2yX7lr5JmGAmWWOqjIMRvEWVl6g7RGnXlRHhvHOu0654Htec2L1Z3KRmmI+GB8V/SbO3J2+ARMQ8+Ja2rqeKcQ6+hme7sdNznzVNaMyiRuE5rIMrsTsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBM2Otyk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBM2Otyk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32901F00893;
	Wed, 20 May 2026 16:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779294665;
	bh=HImxTGXfOlPJ5yiYjEIBIuu3kZ/Pwu0vhqM2t+VyCbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oBM2Otyk38GG3acwx9YL4+hht3BlC2RO6DLXEPjVV1Vsh7ZLEi643kWif4zwoyVDG
	 mdCkNcmWBt3Tkz1FZcfFDRCWBtYrxtTJbGZbG+7K0NueUIvxSPogddtwaQ/5trZez7
	 YZm5M3cbhYFw56xh6pmsMF6LLaVaIyqRk3FHyILZ3k0dEzBcQlP8tqVv+w5arx0teY
	 7arBcOQRGYCsG8r49dV+eF45qjVFqXi6oRxeU0aEzhS4YqPELRT5vwVMDjDX1aVKn2
	 j7IJvJkoGX2HrVbGGjXMLsZ9lsTa/mAKWxwHat519DSuHBOui2+sWI3AQ1hHk1ViJN
	 ODnH+uokvYKtw==
Date: Wed, 20 May 2026 13:31:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chen Pei <cp0613@linux.alibaba.com>, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, dapeng1.mi@linux.intel.com,
	pjw@kernel.org, alex@ghiti.fr, guoren@kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf riscv: Add SDT argument parsing for RISC-V
Message-ID: <ag3hxuypbx5swL2Z@x1>
References: <20260520134004.30573-1-cp0613@linux.alibaba.com>
 <CAP-5=fWApAYb33pSnfW+gRmY7TsPUcfAP1UnBCJW5UpFudpr5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWApAYb33pSnfW+gRmY7TsPUcfAP1UnBCJW5UpFudpr5A@mail.gmail.com>

On Wed, May 20, 2026 at 08:25:50AM -0700, Ian Rogers wrote:
> On Wed, May 20, 2026 at 6:40 AM Chen Pei <cp0613@linux.alibaba.com> wrote:
> >  - Add two Reviewed-by tags.
> >  - No actual update, just to re-trigger sashiko's review.
 
> The Sashiko review is green, I think this can be merged.
> https://sashiko.dev/#/patchset/20260520134004.30573-1-cp0613%40linux.alibaba.com

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
