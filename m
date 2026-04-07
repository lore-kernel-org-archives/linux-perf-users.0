Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9953C1973;
	Tue,  7 Apr 2026 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775576521; cv=none; b=j1tz0IE6/fHWGwkCKyrU53xwd7DHBz2TlHJqGO7DnoCrs4dRYcaaqQg22S2bEPEd2f2icyyxIbLoj7nsulYjkUfi+/U8bDlBi01nRHoc+q/Fj8cBJ3xZb4CgCnU7kAx3YCbXr6JCyOiDdEKS5oLmIoO6eIhKcIwJFx585Rd2nfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775576521; c=relaxed/simple;
	bh=B/C0KOl9abFbjCqd6ewO80I01HoxY7R6TSKOFKKUbWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcj2l+IrP/d96O6gkIRJcUAipzJEPu2KoBxGD1zQMYBybCVbFuqz1PQfZuSimYyEbKXP4c7RXqOx99Q1it7NoQ5IWS/azD9wcmJBZjdeIcOsxcBiva+0sUSY/7CukrDJmJHrlNdPxKrVS3A8jgFwUA519lrb2sJLAufNOHfgwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=olDYGExn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="olDYGExn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974BC16F2;
	Tue,  7 Apr 2026 08:41:44 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D69713F7D8;
	Tue,  7 Apr 2026 08:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775576510; bh=B/C0KOl9abFbjCqd6ewO80I01HoxY7R6TSKOFKKUbWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olDYGExnb2BRryrQ3AtMwDZntGxBVZHYUk+6tlB1uh+ATBbPKb4++pThCg0SDl4lu
	 Ypl8+Nk0vJCUA9LXLbPMushHfRTUqd8y3vqNHH7ReH1g3cAPqtbnxzFfkgz2cnT3hE
	 OJLmtPjtBmt8UlIA+ghcAXFxINPAN8T7Bn4NUO14=
Date: Tue, 7 Apr 2026 16:41:47 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] perf arm_spe: Store MIDR in arm_spe_pkt
Message-ID: <20260407154147.GO356832@e132581.arm.com>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
 <20260407-james-spe-impdef-decode-v2-3-55d3ef997c48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-james-spe-impdef-decode-v2-3-55d3ef997c48@linaro.org>

On Tue, Apr 07, 2026 at 03:05:17PM +0100, James Clark wrote:
> The MIDR will affect printing of arm_spe_pkts, so store a copy of it
> there. Technically it's constant for each decoder, but there is no
> decoder when doing a raw dump, so it has to be stored in every packet.
> It will only be used in raw dump mode and not in normal decoding for
> now, but to avoid any surprises, set MIDR properly on the decoder too.
> 
> Having both the MIDR and the arm_spe_pkt (which has a copy of it) in the
> decoder seemed a bit weird, so remove arm_spe_pkt from the decoder. The
> packet is only short lived anyway so probably shouldn't have been there
> in the first place.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Leo Yan <leo.yan@arm.com>
