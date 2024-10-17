Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118E1DFD89
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183162; cv=none; b=qGw77zNEtAWUqrT2NLKLm5grg17WDsPE9yYzj3XbUJCLkr89d+FhBOkBQPpjrPTdwEP1cEQWDxKtQA9XortiePa53RqjE2G6pSMZ6HFQKKi/sqP+g309W4SbRV9PTGkmaIKEh/ZRh7QtRZ96oxoRZqKgPeBAOV8d8HKHTjAuPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183162; c=relaxed/simple;
	bh=seZg1qIx+Rx79z2DfNz7trH9BAWwfAqlYJyOT5deBl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9Z8BkPfAU+5kLLipMugjljCVRfV2Iq2UjA7H2air63Fn2dwD5CUcU1iQs4AEXHTkO7IqU42Unpi+cvHfGNutd2dKmhwAa5LS4NsurxqQrx8nJ+aJxyAWY9H4PRmGcZfboiFqy+3WcVnJtIb874WMU1sTE/cQ8ue5TH14mhp1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spf1wJjg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spf1wJjg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FC4C4CED3;
	Thu, 17 Oct 2024 16:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183162;
	bh=seZg1qIx+Rx79z2DfNz7trH9BAWwfAqlYJyOT5deBl4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=spf1wJjgTO9A82g4I1yPqvXZKbg0OwgsgucOoJx6ioNEpgv+tB571VTKPgadlqXGg
	 xVnH3H4qWVnutyloFpqVyhC9uJMSYCmOF/2rMO47bWdQiloCrCRFPVZtucVZTzM9sy
	 cBaazKE1GPk5XWlHyxp/TCOXpLFCq5mEDvTs9Odmn+yuolNnyl8tehuyvRUZXd4xm/
	 NirHOtNGq66rvZ++lOgEolHMohEFXE/LvpCuMjSzbInUvG5Cu8pzY9ze1CFHIbOKtv
	 vEfgFc5mR0URuhoWjbfDdEm67Qgp0qCS2QGGUvJ7gBZwb8oVeBrvjNQttatUYhtbq0
	 b4u0lBxwn5HqA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
 vmolnaro@redhat.com
Cc: mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
 mark.rutland@arm.com, irogers@google.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, kan.liang@linux.intel.com
In-Reply-To: <20241010144836.16424-1-vmolnaro@redhat.com>
References: <20241010144836.16424-1-vmolnaro@redhat.com>
Subject: Re: [PATCH] perf dso: Fix symtab_type for kmod compression
Message-Id: <172918316203.639809.13939468676531242481.b4-ty@kernel.org>
Date: Thu, 17 Oct 2024 09:39:22 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 10 Oct 2024 16:48:36 +0200, vmolnaro@redhat.com wrote:

> During the rework of the dso structure in patch ee756ef7491eafd an
> increment was forgotten for the symtab_type in case the data for
> the kernel module are compressed. This affects the probing of the
> kernel modules, which fails if the data are not already cached.
> 
> Increment the value of the symtab_type to its compressed variant so the
> data could be recovered successfully.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

