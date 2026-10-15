Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399AE5221D3
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068332; cv=none; b=jgqQhdX2fFMynqnEgF1Mczw7aQt6V3ngcvNXrZjljBpxtaUlqWQQFOe6sJUhykkILUFgmrLfBwkflYBLqEHNfaelMuYbpN4CYsxGPyGnwNLUQTT+SyZIo+95zlwbDN1WOvkAk20qMYb3Csoc8Hu2sj046/F71kNoWtbrZtEqdi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068332; c=relaxed/simple;
	bh=L4di2U/Tk6vj3ZWeXcR/+wKqrquPcwyyK6qnoEgZ9PU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=hDpHJ1kOHUAjyIE6di1vAah4K+3vdJHLSc6nwUld+hAWZQaDSHkk5YYX1RuuArTl+2g1smfzq58RdxrfnrT6vIxM41vkkprMTXsyWnaiPIzDcrbF+EunTkb0BLhodei9+npsyRvFRGlxHXrV8L+TuOX6sLDmz3QKZm+lw6jyMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD92BdFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD92BdFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55FD1F000C4;
	Thu, 15 Oct 2026 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792068330;
	bh=YiqT8YHjwOMwlEtvCpf4zpoUmwP8rlAzl8R1Xr/95so=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PD92BdFrMFhTUgJ+bBPW1QQBdr7mDC2uMG14pEpbPh1hKstvXZku4ZqS30my1w0+6
	 e3J+52bcZt/Up7m4zNY9bE+EbpfjYfHly88IyuFTSzXTOlqzYr6OfNx2qp4XoiJGP0
	 NYHg0pXOp602vWc1Xauvl18+o2vNxbA/TWCVVWnkeUviuKiD1yapDlekHA1UWLuRW1
	 +9Qutxx1BGzAo6dBtL5qzDWm539tDTF2STFBbY6MZUqHPoafFRA+jKq+NMx7LWfjh+
	 GTaJhAEaUnLCBoMA/7Rx1bXA47foa7GsyHjZt+90nWdV+HnED2cgL03iZkBmq+eIgW
	 NuOqAoX+pXFHw==
Message-ID: <sashiko-outbox-172858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Close owner-list publication race with
 remove-on-exec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261015123416.795008-1-4ncienth@gmail.com>
References: <20261015123416.795008-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 12:45:30 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_event_open() makes a user event visible in the target context before
> adding owner_entry to the opener's perf_event_list.  For a remote task, it
> also releases exec_update_lock before adding the list node.
>=20
> A concurrent target exec can therefore process a remove_on_exec event in
> this interval.  perf_remove_from_owner() sees the published non-NULL owner
> and calls list_del_init() on the zero-allocated, but not initialized,
> owner_entry.  DEBUG_LIST reports a NULL-link list corruption and can panic
> the kernel.
>=20
> If list corruption reporting is non-fatal, list_del_init() initializes the
> node and clears the owner.  The open path then adds the ownerless event to
> the opener's list.  Closing the returned file descriptor frees the event
> while it remains linked, and the next owner-list insertion accesses the
> freed object.
> [ ... ]
>=20
> Fixes: 2e498d0a74e5 ("perf: Add support for event removal on exec")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015123416.7950=
08-1-4ncienth@gmail.com?part=3D1

