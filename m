Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4493E39CCF6
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228665; cv=none; b=k5gUOslpbgILe86imfeu1CQLeiOagyKXgd5olmlvm6xrb4oL5/6WkjvccnmoKuTwcFwms8h70JfidG3hhXt0CNBcRdMZxUD3koJwhPuUwIUMvWglDqe/qdgxuQN/B8tlBMqIZJA8cLFhd9xzf4s3wUbhQumdjEVLw17V776K1zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228665; c=relaxed/simple;
	bh=JaSBoB3M0I4KMHDMMNalsIJGYJ9XNENT/WECTFUY3sY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hNeFHBoSSnfREYaiz6uv2aq5srqQ9Xo9ThfgHvgup3uBdZbg4gOhgbnJuX9r+A0BdCeCwub2g+Zo6FjP4Fvwl6nIpvPD6nQbQp1ITtlug8XmVpCcQqf1ZtfIQmogOWNwyCQtflqcEPhU12Y5BZ4l17/nxq4eSQMeh05Hprgt6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ8VYP9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ8VYP9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12701F00893;
	Thu, 24 Sep 2026 05:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228664;
	bh=Tp6D0j7Fk5SQxC9Y3wAnX+Mq7dZe4D7T+c9dury+Sh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJ8VYP9IfIaj/yorXvIv9ajReRqt7BJwM/oBKjccCk+kC/4U1fdam07WFwXSCIRGV
	 mreOqOWKqGlR6Vq364vVMlOa4CfJglyvASJYFZb7eG68fECmcznN54BPKrZiQRbA0u
	 5NVSgemgKzJ3X3b7L8wSIaSrOc1eGqKWojD18nck7SFmSuEjwsiFP8heiw0sRuoMny
	 Tki5XRD1DmoiySGUZxIhiJCMzMveDk9hX7wCSiScpZ6s0ZNL/rcJb7NwDi9ysxEjN+
	 cID/OJ/YPmQjnY4x36Rkxyzyui1jqxSy0aRdDcqqrHfzys7gD+/bXkhDB0SoQvW0Nu
	 BLMu99SCfKZTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/21] perf vendor events intel: Update ivybridge
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-12-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:44:23 +0000
Message-Id: <20260924054423.D12701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated TMA metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D11

