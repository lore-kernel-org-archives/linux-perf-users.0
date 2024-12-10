Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34D22046B1
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Dec 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856336; cv=none; b=V0vbz7UJ4FVtFbQNSrxvulTXGZt5B/DIoBBGG95445Zhb2YiMKgYXsUuqntylktInkkbNEMkMi9FugG95uVByh1/YhBGnKCNT5g1ASFyNQBCZTS8PZn8ujSlAMJ4nWv/wNbzvfPa5efk04VuVsze2DGgOmjS6SQ3zG0n/64AEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856336; c=relaxed/simple;
	bh=Q5Pz7EHL3n3X7uPhiMsKWFnq43D6GpMMCNgCe+hv4rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htUJrVlzS3cWy8aUV0S+EyOrKSiWL2jsIZjTXpAgF29FnZiVK1ZvUdFYM04ptI9/y2sQouHCrsC1SP3LZM2L0C6AGp1rBZvGA1eYN39/yTPi1nfecVCt5AbgLLGc6CRtqggBGs6Bqk54nFD1GymMZTV4EMnVmPNQWTtMRgJ5qhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2DD97JP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2DD97JP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3822FC4CED6;
	Tue, 10 Dec 2024 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856336;
	bh=Q5Pz7EHL3n3X7uPhiMsKWFnq43D6GpMMCNgCe+hv4rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2DD97JPy/GWO3SSMfSJQCoE/mD8W8XZd/LK+KDf+qoNIJ8n3LLTfkIQiGSFy6/hK
	 IThwRX7tUrQOnR1dP7+jIfskNEeJ83y3PhlIrF36peboUA3P0A1Si5zdTor4NK7Gtk
	 ALKRbki6hd1JH7Avmyf4ml/X8+EDkKbu8xAFFugeMzLDknDEdNgxl4p/rY+EB2h6nT
	 hmaECHj0YkWdtnaO9ock4/yc/XMet/DRO8NpBeiq2fWjzZOrNk9CEydczsxsI8wzIk
	 a/712IIKKx4z8rKRie/FPhAejrZKOQ0QYZkY3fLkhc9g3qpgyvWKrznqgO7TNiAMGa
	 84JvXWqnL9Z0Q==
Date: Tue, 10 Dec 2024 15:45:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	acme@redhat.com, mpetlan@redhat.com, peterz@infradead.org,
	mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.co, kan.liang@linux.intel.com,
	yangyicong@hisilicon.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH] perf test: Parse perf stat Topdown events for aarch64
Message-ID: <Z1iMTjb3kXp0TC7u@x1>
References: <20241029144347.25651-1-vmolnaro@redhat.com>
 <CAP-5=fWAH1qzLrFhVjrJBu33NSfqktM30thUohC-zA+94_sf_g@mail.gmail.com>
 <e969a01b-b6c5-4632-b626-e1e3938989ba@redhat.com>
 <CAP-5=fWfjB9O_oR7k5xCoKYHVL3t6tppvemZewW=q2PWh-da8Q@mail.gmail.com>
 <51789413-f4d4-4085-afeb-aedffc36c3c3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51789413-f4d4-4085-afeb-aedffc36c3c3@redhat.com>

On Tue, Dec 10, 2024 at 04:13:27PM +0100, Veronika Molnarova wrote:
> On 11/18/24 22:31, Ian Rogers wrote:
> > On Mon, Nov 18, 2024 at 2:04 AM Veronika Molnarova <vmolnaro@redhat.com> wrote:
> >> On 10/29/24 16:25, Ian Rogers wrote:
> >>> I saw similar issues and sent:
> >>> https://lore.kernel.org/lkml/20240417183219.1208493-1-irogers@google.com/
> >>> but got distracted. A difference there is automating the generation of
> >>> the skip_metric list rather than hard coding it. Hard coding may be
> >>> the most pragmatic thing to do in the near term.

> >> Automating the skip_metric list generation would be great, but for
> >> the time being, we can stick with hard coding until there is such
> >> possibility.

> > Acked-by: Ian Rogers <irogers@google.com>

> Ping on this patch. Please let me know if it's missing anything.

Thanks, applied to perf-tools-next.

- Arnaldo
