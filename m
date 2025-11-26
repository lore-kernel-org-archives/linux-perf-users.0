Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42D03595B;
	Wed, 26 Nov 2025 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764118334; cv=none; b=sRD/kWZEx0ubidlxBewWsSIrQTJB9iuzfylht60aE0UCtXMJJPECNft7OJqhkjzBKiHt2Swn4kLQPYKBZKOUaO5AR1tLzdgX1TbJD5FKvZ6LoG4usujODjXw9pHQsB/Io8JHgoPtaAmIMOlEuYdSrV5CEk9EuKgketpUxBYT+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764118334; c=relaxed/simple;
	bh=C0XseEjLPJm6JB1tPLzNcAsCYsamWBPPJFl0+3phHoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WE6xKAwUIfXrlj2RYGGnL26HGIQ6PcVzeEC0Ulmqo5gGAKetWJzut5VYengwd7L1JOiTqZBb5BzjlXdTuoFFCuCaWAZI/S+HaT/Ix7TABTNZIho0ETpdac4exxv2+llrVIjCPVMd9LsPhmaChuUoEkUTQCAzxpfVcbq2iQbWT1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CundQTJL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CundQTJL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158A2C4CEF1;
	Wed, 26 Nov 2025 00:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764118334;
	bh=C0XseEjLPJm6JB1tPLzNcAsCYsamWBPPJFl0+3phHoo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CundQTJL7ilMirDV9Ew4adchtwf3uRyv8hLplnvIWO0ygoKIJm7WR7n+2IyAz3vxT
	 mC5j1E5bGlO/6Tm9LuquJozUiLeUwkOw+qanpt5/IhJ0v3liGtc434lVgjYQqvQT3/
	 0HXxoFnFXoWlI9Roy7dM2l+zEiFAH9BHlWUw3UrAW8NQUeNymDrzIdYiHdK8qLboFV
	 zKBYh3k2ouz6jQZk7kxCNcqNn7hPfkr6NoD+IzyDZCtj4wGzeCR5DELaoZGUajMWho
	 DbAJUyKr5kjA2r/u+URaY/5HBI635NMgHzSq8ZdvO0klR4gJX3I2K2wylcEA1dVq7/
	 XvJzdiLeqROmQ==
Date: Tue, 25 Nov 2025 17:52:10 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>
cc: Inochi Amaoto <inochiama@gmail.com>, 
    Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
    Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
    Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
    Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    Alexandre Ghiti <alex@ghiti.fr>, 
    Samuel Holland <samuel.holland@sifive.com>, Eric Lin <eric.lin@sifive.com>, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
    Longbin Li <looong.bin@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2] perf vendor events riscv: add T-HEAD C920V2 JSON
 support
In-Reply-To: <20251014014830.613399-1-inochiama@gmail.com>
Message-ID: <ac26535e-01c8-d8c4-9f25-f5716065b37f@kernel.org>
References: <20251014014830.613399-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hello tools/perf maintainers,

On Tue, 14 Oct 2025, Inochi Amaoto wrote:

> T-HEAD C920 has a V2 iteration, which supports Sscompmf. The V2
> iteration supports the same perf events as V1.
> 
> Reuse T-HEAD c900-legacy JSON file for T-HEAD C920V2.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Would you like to take this one, or would you prefer that we take it 
through arch/riscv ?

If it's needed:

Acked-by: Paul Walmsley <pjw@kernel.org>


- Paul

