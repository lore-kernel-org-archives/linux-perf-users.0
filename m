Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826533AAF65
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787956045; cv=none; b=sfVrISB92IZM7wEeuDC9PUKCLgMac1HkXjmu4Ub9Pw+rFWBuOAoUVQHMcokRTAU5IQzq8WqzJHzA6XJ+XT26Q3tB1S5JmThE/XnK2QMSpIjHenBjU/wpYlkJXUNOyrUXvqpEh2jUxzrWnsjjE7n4/oNTMytjLNjuwVUNQ3i7I8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787956045; c=relaxed/simple;
	bh=h6EsceAgE82UQx8jgBXUmyE3MkkGGNcBz2lbCCslwTs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSgVLqDvNxnrq6Bax/Z9T+JZy2o5E7u43WFVU4QZb9M+bIp8JSM5GrOnjSbAg4NTjVUoSZlkAcaGgZjIGs8qRhPxfmQ7yzGt1h6RuuZL3gJU+aW0VR/Bb48Cs4PNpjmhewOo1wMOcnMm6mVUepDCUUm8YiRiSJNqII3d+gTg6hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQp8+IVC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQp8+IVC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F3E1F000E9;
	Fri, 28 Aug 2026 22:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787956044;
	bh=h6EsceAgE82UQx8jgBXUmyE3MkkGGNcBz2lbCCslwTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MQp8+IVC9ZJDTOHM6/BGzKfoUHyz3XwHqzZ9SPj+YaGEYwoElxheNjXkyuwic0Q7q
	 sGt+/gT5zE5YdZS4YclmMsOZXwxEE34PnnLAR8XRaQHEt0mAI8chLLvxy4VsHZr2dQ
	 WPlH035tXP9T0wdHzLRlQygXzDaDJSrg9G9y5pkzYbmtDNLAXGFn9faRue1rZ8SnhU
	 8brDqhW+ZCHxOH8tnieHKRyvIOWk+/VBtCdifTiMvzRkLUvcbnCyJUm6C2QB9MAnDQ
	 Z77nZy3qPjIfr2AM0PoEhlkEql0hmGoX97dQlRMEgxOFvv/fx9WnHK6xFJ0PI4fEd/
	 L8VPwE0wSgLlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] perf tool: Sort headers from previous cache.h
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260828222045.1314766-2-irogers@google.com>
References: <20260828222045.1314766-1-irogers@google.com>
 <20260828222045.1314766-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 22:27:23 +0000
Message-Id: <20260828222724.00F3E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Use git clang-format to sort headers.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828222045.1314=
766-1-irogers@google.com?part=3D2

