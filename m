Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74CB226550;
	Thu,  6 Feb 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738834774; cv=none; b=j6SqlXE5yz/XiB0BzyNiJj9eStx9W8rbetOIGKK/wsgP/sBSU489Y9POmjk2C9An5Z+9EEZZ85vU4VCilY70uFyHI0NO/uMMe9JQr8aGIvRj+1RJSyb3uTVA8219N1kssKrQheu8snCKaIvHjfrSt2IG4q31K9PqJZDJwgRcKpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738834774; c=relaxed/simple;
	bh=4Z+SmOeOTuJIBO+M3xC8mIQ92PzyLU2TSKIeOxBiQko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uh7c6EjLp/Wvd7Pgq3BMy1KcYMFRtjBzmp0tRX+tVQ1iDEC6TBzx+GVdxPnIekX0QCkejrOS7FkJAEHFAH5k9+6bZ5+repEmXPug4sJ7fb19DkQCZahRLMWtFrUCnRU8dM1udf48jO4fR5Hsnp6I9dRG4oN3Kz+7ptwnM9LNhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AgqLVFSP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AgqLVFSP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Z+SmOeOTuJIBO+M3xC8mIQ92PzyLU2TSKIeOxBiQko=; b=AgqLVFSPtAbQpYaXUWHjVRqOkI
	G8VazF8oUt9korqdXA3KSJa2FFVRMZgHPkTVskNQo4Fwky2r896VuPeqJ36r1qyp8j4GFyMQhIzQ8
	JLrNpLcjNR0KrpCSFQgF7gPHkym8OU8nXR2Mmrcd9nfW67rcom7hyZQd/v8okR3yl3XAlxQgD81EO
	ZFOIZ6yd1UUb1hCD8/zL46UVkaC8GuDzRPtbUybwUpO6EuqfiCf++zes2bBjmQkYqUTH7N3UvnDTn
	+PJ/uY9PEfQ4kj3i31CN/vMeC+UAha7inBTxKfFElYl8GuZM8cecdwVvXU6yWL2XjmiPBJKGWtcfX
	JeSk07uA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfyM2-0000000Gtys-1EYQ;
	Thu, 06 Feb 2025 09:39:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2EA5630031C; Thu,  6 Feb 2025 10:39:25 +0100 (CET)
Date: Thu, 6 Feb 2025 10:39:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 01/20] perf/x86/intel: Add PMU support for Clearwater
 Forest
Message-ID: <20250206093925.GM7145@noisy.programming.kicks-ass.net>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-2-dapeng1.mi@linux.intel.com>
 <20250127162651.GL16742@noisy.programming.kicks-ass.net>
 <d31dcd21-7455-4108-96d7-e29ecde1c5de@linux.intel.com>
 <20250206075356.GF7145@noisy.programming.kicks-ass.net>
 <16417b83-af65-4ed2-9b9a-c82363abdd4a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16417b83-af65-4ed2-9b9a-c82363abdd4a@linux.intel.com>

On Thu, Feb 06, 2025 at 05:35:28PM +0800, Mi, Dapeng wrote:
> ARL/LNL are all hybrid platforms, all the event attributes are defined with
> a kind of P-core and E-core mixed format like below.

Ah, and there is no E-core only variant of them, like ADL-N was.

Thanks!
