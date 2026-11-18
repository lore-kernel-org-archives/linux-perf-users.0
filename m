Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794973609;
	b=n0L1paMzAjk+h8LK9aQYHBxrqQUetph/1kvHGuk2TPLwbzj7jQqNb0rlXGINLY1y4d7k
	 vZtnNI0NnhX+QAefAflDA4X58nFeJoWABQ7Z0GCOZqHO/ECWubFIt+qGE+jKeBeNhk5PY
	 65izaABlWtx+nscYdQJ3i65lANJfq9g462fDLVyZxvC4PUNY7D9XXXcchTNSxKgu1KFr8
	 6CeYOY2rXQYIKiwRpIR6/HzNVuGdraps3sazrWDapAimQTj/4aB56J/RjX/tLBMsB3HmD
	 f94sEDWqV3dnHyrtd1A9rsLx5sKSSWygEpAsdAeDyyECyYfKHRNta3EjZRG9Rm0InYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794973609;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YPhS0MmmpuiPXbkjcOprEfgPNM6e867Z46ECBHOVCUQ=;
	b=uhjd24eerXPJSbtoq2xiLKavwZddG2OYOFjMTFcWRQ3+VwxbhPw7ikmPfznFD+kBKXtg
	 JvYWscw+9fEPH+7A9EZyrd+9FF/Opi7iBJM2jr72/R59y6fh+Mf+rf5WzZmrAGJywY/zV
	 8b2YKU3VolEcY17fohEwrXQGSlU2uWrle7PWoPm6l7Bb+TbmMygS+aHM84fZaGOOJnz0F
	 bMID+zJs9KHOxGbHIyFvbZRmjEbG3z3r6zBTBtfwUbsVO2NfxFXzY9iJ02bjAQon6EP5V
	 vhdNwsXHpc3AwuyynefY16IYPOtAdc+Ol5L7NgSwMADUwIYcfUV5fAzrgDWgWpvyyxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHDBCLZZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB9606A325
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DHDBCLZZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181771F000C5;
	Wed, 18 Nov 2026 03:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794973609;
	bh=YPhS0MmmpuiPXbkjcOprEfgPNM6e867Z46ECBHOVCUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DHDBCLZZzRgb7oZveP6PNDAxIQ+ZUJ0CeYn+cVL9RrsB9s5vjdcizjmBfNZ0gskWe
	 pDJUek00uUHGE+iBKRSD5jLFYlOoIwEiWilrxGKbFDtfqwqivH74gLu4BQNoIh+0Fu
	 YnudAgPgSdM7TGhkrLbgH9vtxqZ2pv4f/IF43NhuADgAnkDy3WJXHU4fqh4biH6i7h
	 UQvbHO2zPBGk0LpcXkombG43GDyD6BYsxEghgXxO5eTIMR0cwLLbHIJaw+qtshEsya
	 mkUy0GptM7KcNNWko+F/ZHwBPEJ7sYVJK6+f3QadrehR/NkfdpXDLVV5bt7WDIi6k6
	 hVyHv5zXinUow==
Message-ID: <sashiko-outbox-220045@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 24/24] perf/x86/intel: Fix incorrect PERF_METRICS
 overflow bit clearing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118031453.1353625-25-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
 <20261118031453.1353625-25-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 03:46:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The overflow status bit for PERF_METRICS is cleared incorrectly in
> handle_pmi_common(). The code clears the raw bit index value instead of
> the corresponding BIT_ULL(...) mask, which leaves the overflow flag in
> an incorrect state.
>=20
> Define GLOBAL_STATUS_PERF_METRICS_OVF as the proper bit mask and use it
> when clearing the PERF_METRICS overflow bit in handle_pmi_common().
>=20
> Fixes: a5f5e1238f4f ("perf/x86/intel: Don't clear perf metrics overflow b=
it unconditionally")
> Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record=
 fragments")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118031453.1353=
625-1-dapeng1.mi@linux.intel.com?part=3D24

