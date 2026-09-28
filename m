Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66DC347C6
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620647; cv=none; b=KMh55BFu9p7F3C/dmXsLVx2HcJ6FKI2A9aZrXy9QUY25CKeRNSiZGQCo5lJKSKJKIHZHDwJYWaPyY/1HgDwjjWVPV5CKR7NcKaXeMX+X4Oc8ab5gU98TpVvxowuvVEpc3gvpRg3y4iuOoDfrQykN6lHq86tiZ3605sCBoIlPqlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620647; c=relaxed/simple;
	bh=ch4esAOZlWZeTMkJNjNpcAxzcVS6SLTih7tpktRPqg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X/A4AULZSL8CUizfNk9uTAJpBMERVkyNB1osrGx7yDjMCE9SMPW1MaILNwOiVunfqEmOQm6VzD3MQ9mhRnNnD09APW/RgnFAu/mDtQKMdzwxrT7K3YDRG57wcea2pBmdXKoD0vh/U5KzBcz+m3m6xfzBA4RZdZTj5CMVgino8Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIC1cSCo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIC1cSCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5844C1F000FF;
	Mon, 28 Sep 2026 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620646;
	bh=ch4esAOZlWZeTMkJNjNpcAxzcVS6SLTih7tpktRPqg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZIC1cSCo9aGH7TCqP7hMLgqExxZkA3d+zAS98yjoNqLHwVylqNK6CRpADWG+/1F+u
	 8Rjb4GUn1iz0UayRQyLwSQWXrV/xWfTK9+7TOXzu1BS3F5CQ1HbtYsv3tesE5WyF1q
	 TybjuTM/KvVjRewdOAWh2OvrWxmIf8vz1tpkvfyp6giOpRl2VfSLfmYPiGBWrWIWO6
	 d8ghKITkuxsR4lNu53aaxJr/vR0EZcYvtcGAZwWN8NMdmPeOjdqLbxZNKBJ/Ge2Cx9
	 AoorLOXzh/huHAlm5FxEKicCvdcLNzyQJvRmYjOApxGg1pxE8kyWMd8v2LTLCIWs4u
	 zJm3ucFP+252Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/26] perf trace: Use the CPU map index for the BPF
 output event's fds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-13-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-13-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:37:25 +0000
Message-Id: <20260928183726.5844C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> augmented_syscalls__setup_bpf_output() looks up the bpf-output event's
> file descriptor using the CPU number, but the fd xyarray is indexed by
> position in the CPU map. With -C, or with offline CPUs, the two differ
> and the lookup finds another CPU's fd or NULL, leaving those CPUs
> unaugmented.
>=20
> Use the CPU map index.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D12

