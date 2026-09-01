Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024884A015D;
	Tue,  1 Sep 2026 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288776; cv=none; b=NeRZsidiG0vYflp3n6YAUwyXYxM07I9dbq2SiIzgcDc1GdU3gsknDWECzSGx/wfyZN+LveotCJ5TDFS/NsNW4cAOlVNqmYzW/i6pO5a++s6Rj9sZy2Gw9QlkQXZs3np9mRmchaYgLro/4HiWWUhFLx3G+cEn3O+QDrULaie7G78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288776; c=relaxed/simple;
	bh=D0bIaNxuuevGOf3Ss4dzn3mgEV1MKBLfRceDYbhMs/I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IwJVYOI53IKzqlHUDATgPzGf56iA7RBnoOc79gtbdooPsyxMPdz/2EdS/CgxQO/cpy+88JTU4RNjZj7hHnNbhFGLJ9l1DiMoawyGXsP1nj9VpyCY4pQsU4k0RfhkigqtfTOxfRA+VxEq3/Dp0O3cvZz+NqiB33rvUBWoK8hcvFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbX8JkR9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbX8JkR9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E511F00ACA;
	Tue,  1 Sep 2026 18:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788288774;
	bh=XusDj8m7nrtABbX3eM6yTGtbV45R/ekzcSuqzUXyGAI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=LbX8JkR9xXUM8ICTxc5tgVtE2aL0rx506M21DkIQ1d33/t4yoKhksXBxEui3GmMqw
	 Wca3FRlvNzhPcLc7SeuYRSTUwhgKzAYDoQNHg9KxCCBUGP3M4Ep3/OWh6fUnQaGnhL
	 80+RQVpq9zqPv8jfNKYwCKTVRxINdlVdGz5iteg4nImKZuCQ+/h7JeRWXgjhVv+12Q
	 EOW35i4ZTrdpAzJnlXBeKAl8zkZ0shxUlnLXuTPtbETehGND3rxbk9ENXHfueVv5M+
	 FAnBsBkJNdAYf7wRdsna1slcZuU2PTyWL7bxGBozwbAEpkpWJmWv0HjbXRWX/isNgl
	 VKfEys8XN+dMQ==
Date: Tue, 1 Sep 2026 12:52:50 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev, 
    anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf: RISC-V: store available counter mask as
 bitmap
In-Reply-To: <prpmask02cmap.v2.1786434000.git.liuxixin@kylinos.cn>
Message-ID: <460ddaff-bdad-0eb6-a504-1ea43689d6dc@kernel.org>
References: <cover.1786092600.git.liuxixin@kylinos.cn> <cover.v2.1786434000.git.liuxixin@kylinos.cn> <prpmask02cmap.v2.1786434000.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Tue, 18 Aug 2026, Xixin Liu wrote:

> The available-counter mask was a single unsigned long, but iteration
> uses RISCV_MAX_COUNTERS, which is 64. On RV32 that reads past the object.
> Filling with an unsigned-long bit at index 32 and above is also wrong.
> 
> Use DECLARE_BITMAP and set_bit/bitmap helpers. Walk each bitmap word
> into CFG_MATCH when checking events, when allocating an index, and when
> stopping all counters. Set the counter base to i times BITS_PER_LONG.
> Share the CFG_MATCH ecall through a small helper so the 32-bit argument
> split is not duplicated. On qemu-system-riscv32 the probe bitmap has bits
> above XLEN set, so the first word alone is not enough.

This patch results in several 'checkpatch.pl --strict' "check" messages.
I've fixed them in the queued patches, but please run 'checkpatch.pl 
--strict' next time.

thanks,


- Paul
