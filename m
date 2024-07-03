Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7B191F8E;
	Wed,  3 Jul 2024 21:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043595; cv=none; b=jIIPSJ9TI8Ab064BOswtbFlbWvDVWKDae3+dUpbVDOT2jn1l8NArsZTZnnFXQ1r7sG4BXyg/BcsYdeKfg8U9D1vk9BpSthQ2hFfhmaKG4NYhFTBec6rXVSKLJDiMY8gmnS8iZkfjUkqK48nAbAHHLRb+cI4luqkmVlhQErXUIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043595; c=relaxed/simple;
	bh=EoX513EDEZICnXv3yAGou7CPrLBwziHXypDMjhVRvm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+g0uhLyO/eBpHuKW8eawGLi/knLwmFlSnZP1J2rb5m7n2UZS3rCj9F+LcauJjWydZBpb6ImKyRIE3ki4EPdHsCjsnrcSwEts7JgiW64uIBLNZe5CnBBOxbucrtgqsUo27EWSpU40lu63nvlKc0TXNnNG9ZOsMqAPECtobu+ojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWLQZ/k7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWLQZ/k7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B06BC2BD10;
	Wed,  3 Jul 2024 21:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720043594;
	bh=EoX513EDEZICnXv3yAGou7CPrLBwziHXypDMjhVRvm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CWLQZ/k7qZhU2o2y7z+5qDb/MGabHPbWUptEbLH7jsltVHiv9FCuqFT60d6nkspyf
	 O0a/JVdhsll0FtcFmUFl0qSi3PqzgvOUGXCzmG3ZEGGW1O7vuM8EzNRlPIDHs+xmZm
	 onypvjmbfV/NrqcCbe9yyZo4gaXMW8O+4Vb5k5kl2w1ox18a9KQcCuTtCQT8Y9Pz0m
	 FWtewMhlEJbAQB9hIIc5xtLs2W6IWHBPo8AQ+5R6vKZCIZbRjhTbegs3hsPJ4Kd9qX
	 +HgX0lnj52ScJA8eNV70atG630jvgq6vc1/z8ezZjXK9yR1MtBlFVam1cRWEPyBEYw
	 YHHaoRrsYEYMg==
From: Namhyung Kim <namhyung@kernel.org>
To: linuxppc-dev@lists.ozlabs.org,
	Abhishek Dubey <adubey@linux.ibm.com>
Cc: naveen.n.rao@linux.vnet.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf report: Calling available function for stats printing
Date: Wed,  3 Jul 2024 14:53:13 -0700
Message-ID: <172004357966.3801669.9283730297152342211.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240628183224.452055-1-adubey@linux.ibm.com>
References: <20240628183224.452055-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 28 Jun 2024 14:32:24 -0400, Abhishek Dubey wrote:

> For printing dump_trace, just use existing stats_print()
> function.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
