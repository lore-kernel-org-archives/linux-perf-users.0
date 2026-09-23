Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F283F9281
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148105; cv=none; b=Uw3FA0LMHm9Vv3I5IQvcGAiuGw3OCgNCITR3ByqfRObQ5odxUoCZ07WCkDTVy31OV11gdAvW9MgRdrhCft/Z+YoXvi4E51HNxirtFD9Jz7wnmfMN3fCDczLkrDCjIB5KlAOS9UlNodm3GnwjjUIUnNmEbrMuergMFJofukQKtg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148105; c=relaxed/simple;
	bh=yloX5fnVaZ/OGvoUy2nFlHK5vU83BmZNBwfCFWcF4yA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OLGZHqx90nVMb/fSYtmpUovBXr8MCQxYBKAlItPzRF5JLaFmVEmEKt5HHwGUr3vYrzQWoqik3KFDs/mVycPfckIpwMeuhdxejLVWvo+2nghBegyuzq53zMEfgHVwXkT3gwTr6LXbcoPhgpe8Viyj0swVVa3NXytEOvsP6s04KkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6qFGS5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6qFGS5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD11F000FF;
	Wed, 23 Sep 2026 07:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148103;
	bh=FUlmtGCPjq3NW/Aqps/3pDdY5WAaDKtXsfwSWhTTri8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6qFGS5tZgaoF5Bcx7HWNiXBGWgpLXm9zXmvWnIjs0LWgVuMeeKAITYNWPKECHuGW
	 0MKYAlOBb6H1d4PH2YnlawTJNWi2TINaROpZictNFePr+/OWMudm63xNqhz6HkRxRp
	 j8NWHV8HV22k1wQgn8IiEzOjBrXZvROZv+aYEy93kNqPYWxqPpzMTc2A8MKJ05liE3
	 E8l0NvcMYSHzk3v84qVslnmyi+HT/GPC+Z+OzcXh4xqg9mXdvFNTqtqWohi6AddLgF
	 VQXlpXtZ/7kJzmGoP7AX1g9M5zmbLUhAX///zmgPjWIcmdGkULS/67QpOxhqkdp60M
	 k3o+SvAIB3v0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/23] perf trace: Do not read sample padding as an
 augmented argument
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <ef191bac73ace3ff810eaf6fb1cbe6a45f35be2e.1790145937.git.irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <ef191bac73ace3ff810eaf6fb1cbe6a45f35be2e.1790145937.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 07:21:43 +0000
Message-Id: <20260923072143.C1BD11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> syscall__augmented_args() treats everything after the fixed tracepoint
> payload as augmented arguments, taking any non-zero trailing length as a
> struct augmented_arg. A record with no augmented arguments at all still
> has a trailing run, because the raw payload is padded.
>=20
> perf_sample_save_raw_data() sizes the raw data as:
>=20
> 	size =3D round_up(sum + sizeof(u32), sizeof(u64));
> 	raw->size =3D size - sizeof(u32);
> 	frag->pad =3D raw->size - sum;
>=20
> and the kernel writes that padding with __output_skip(), which advances
> over it rather than zeroing it, so the bytes are whatever the ring buffer
> last held there. A 64 byte struct syscall_enter_args therefore arrives
> with raw_size of 68, and the 4 bytes past the end are stale memory that
> syscall__augmented_args() copies out and hands to a beautifier as the
> size and int_arg of an augmented argument.
>=20
> A trailing run shorter than a struct augmented_arg cannot be one, so
> recognise it as the padding it is. The length prefix and the payload it
> describes are checked separately by syscall_arg__augmented_args_valid();
> this stops the padding being offered as augmented data in the first
> place, so that the syscall appears with no augmented arguments as it
> should rather than with one whose contents happen to pass validation.
>=20
> Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
> Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790145937.gi=
t.irogers@google.com?part=3D10

