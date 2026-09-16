Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398434AB03
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540561; cv=none; b=VghkgTztLgG1nOkvmWAk+e1QqEtRothV/eYKJ2PkxjtLNHp3VM79EFMhNK4Oy5BE1ItRIUt+SnDJH6aXndMgd1OFWDGar2Y1tye+OR0f+vqxh4qy4LlloAmDX0zs8HsQCAU78GzLMz9ID770DR/mdqhQqJf6jb3Mhi4o2UWr//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540561; c=relaxed/simple;
	bh=dyp/3rYXHSlgJSijooLv+MxEUrl6xJn4glqmdq/X1kU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ntJbsduxkmJxSJS8NneWeYgi6ffj0h+tcLzpTpP8KyufTguWZ/PeZ/lijdEZa5IB+1/8gEZ9lIPnSFQroIw7+R1QJMYOpOcLNAOH4nF0JrSyJf/rrc8wEgzTMNNm45E7EVEFefK6MLE5ZPqYPR7rWsAZGIG7NOVp7c5i6PSLOZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jY2QcMfr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jY2QcMfr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2FA1F000FF;
	Wed, 16 Sep 2026 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789540560;
	bh=DaeyrVTIHJGwHyWdwDiM6XaZtBD+gMAnEReupox7oSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jY2QcMfrZb6hjgzpR0MoXKSz3+/VCK9fUrL0sE8rOszegpVW8Va1zkx1XNbohTeFV
	 M30AypO7p970TQugEgbxbNxEAdbFzrw3Omk9In5O0qDnatgG2lsnmZDPEbAvlVEID1
	 4r0soVT7rkfDy6FxyoDK8teNBIUfSfsb3Clffj8sC/FUS2duhfv6xRhj8mUoNjXJ2r
	 AtljIxPckbjZu4CyIS49uAtd2UMtog1B11alrx1HXITImOKp7pm667NtRjS5NvU42T
	 gL6hgr2PWbonMPPQMtzt0WsWZHkfynRFaKkr+fAYa9uihuZ92gB6WsuePemQ8+FE3o
	 BcPI1PghJB61Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] perf annotate-date: Allow out-of-size access for
 flex-array types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916061926.2224222-3-namhyung@kernel.org>
References: <20260916061926.2224222-1-namhyung@kernel.org>
 <20260916061926.2224222-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 06:35:59 +0000
Message-Id: <20260916063559.DD2FA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Structs that have a flex array will have accesses beyond its original
> size as the array was declared as 0 sized.  For now, it just allow any
> offset bigger than the size.  It could be refined later.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916061926.2224=
222-1-namhyung@kernel.org?part=3D2

