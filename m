Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7559B157487;
	Sat,  8 Aug 2026 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149156; cv=none; b=PyaC0lgIYk7arrjbPDsRu+koY3cpDaNDlRjOIcRkGg6xW9NnvhNnKh8+99AJcaaO1yE4bNNieUF4zRSWAhWaJ6TSEb7SXLpj2MC4TaSdY7QCesA80FGkCjf1M1Gu0/uihV313EpgsTAKaxaX0gGY28O31vQwbBoyuTGTEvz0ne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149156; c=relaxed/simple;
	bh=MfgPd2QznvpRyStY/1+FN8ASaFW2u9RkKzWtezAPryg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=SUENPB3EFk7+BT3Bsi94u9Rygk+eBxR08dNuy026xvnye4qUszLfRplEHpjmXY18iX3AGzlbq6IhBUr/7qG1gKS/iM1xa/2aTE/8s5jlBNAx1jDCAcM5NXphhLDMdvYepjnLWOAnAjJigT70vIgJad6aNygHWnkbDqDeu2MmZ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VazOFjkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VazOFjkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488111F000E9;
	Sat,  8 Aug 2026 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149155;
	bh=dmc3Sr56uC/xFBzOAHwswW+8EC/Y4FNYJBinKHwg+a4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=VazOFjkvaOFHy83xSYbjGqgdaUthYOr5MtKzcB3yK8A8ZS+jvB/e34IjhXHZ+TK2P
	 Es/ZNvFiJ4H+5zPlprKlcYVCvlS7RkCX5fWndtR6zGgAXfFkPUnKPVdkFDlaVXe1Az
	 VKH+7g7CmbNsBDAFEzYn3vazM0oM7qgg2+MDqIp21q05AUm2SY9qgDovLj63IgNKky
	 T65hrSpEmR8Ob4MD5uGA9lAxasp2NBrh3WL31IT/2MapHM9+BbXbkzErx16wXG0k4P
	 VJCjBGP9ZilU9Eb2O9ODfz6bH/XCA4VbgXahLrrD8Z94AHysRY0zv/WUyTkP4NhuVy
	 RZSGcG+NwTlNg==
Date: Fri, 7 Aug 2026 18:32:33 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev, 
    anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] perf: RISC-V: store available counter mask as
 bitmap
In-Reply-To: <prpmask02cmap.1786092600.git.liuxixin@kylinos.cn>
Message-ID: <93cab992-f808-8f3e-03a6-19d84baf38f3@kernel.org>
References: <cover.1786092600.git.liuxixin@kylinos.cn> <prpmask02cmap.1786092600.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Fri, 7 Aug 2026, Xixin Liu wrote:

> The available-counter mask was a single unsigned long, but iteration
> uses RISCV_MAX_COUNTERS (64). On RV32 that reads past the object. Filling
> with BIT(i) is also wrong for i >= 32.
> 
> Use DECLARE_BITMAP, set_bit/bitmap helpers, and stop counters one word
> at a time.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>

This patch contains several array indexes to element 0 of the cmask 
bitmap, but that element is going to be XLEN bits wide.   Does that 
actually work on RV32 systems?


- Paul
