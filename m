Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A4938D40C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620746; cv=none; b=g7esu1voF47oa73Yme8RURDYU7nVpQX6jWzrIDEHbR6RtY2JLlFFEIw8Ykvm3ba60cAiIYYEqSMlTLeeijZNqxXyvtacCSZzntYWt9WmYuaepzX2HnSXmC9XBakGzUk6BSzabtIHmmc6XNRUOfVBb7qi9VcKcH3BuElgv05gaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620746; c=relaxed/simple;
	bh=nE/dpCSvWfJMf2SMJ6od/WVxg2oX5f9WpQGtoFwCKdk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CuuumdDuU8cRCx5oFcR27qvRBg4Vq2FiUFyhUn8uFReHFSnTrPLjOKcd2aAXf/aomBVUgD5AR9DbLPes1qdCJiZFwtYtkBuO92fFmioc2ZdnQe2E6zUpJsaXDa80GyggS0oyXtK3QCSGF02KUr5MdFUeNc35JHdx8NfV+C79xfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAJ9rYsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAJ9rYsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D02D1F000FF;
	Mon, 28 Sep 2026 18:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790620743;
	bh=nE/dpCSvWfJMf2SMJ6od/WVxg2oX5f9WpQGtoFwCKdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RAJ9rYsuVcmTFh0BjO4ephhetgIpYUHmsWIqa8/DtOgVbX1wJhbbtv2oDaGpGyCo5
	 0+syg8R/Fw8TEq/XKZf+ymGiV2FlmqxctCs1HUd5IzauTxtlSl6eAOXQ9huRstvDoY
	 8YmZ701UruixB//J7hqwNXn0yRoBZfIc4LW1iPzpEOQDuqJa0x+TutjfGskphzH2AH
	 1C02wgwecfjxpKetNRAcfUB2Ys7RxWj85THJjdk2hXZCP7PyDLGhTXGa7ZBlrJ4baW
	 YbL78q3Lhog+uGa7LWWudxi6eH6v8XjzRSFtZh/g3xmfrOGxANH2xCQU+pJdNdHvVn
	 qMWqb82FI8pVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/26] perf test trace_btf_general: Drop
 --max-events=1 and make non-exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928182605.3649015-25-irogers@google.com>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-25-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 18:39:03 +0000
Message-Id: <20260928183903.8D02D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> With --max-events=3D1 an unrelated event can end perf trace before the
> command's syscall is seen. Trace the whole command and grep for the
> expected line, as trace_btf_enum.sh does, and remove the exclusive tag.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928182605.3649=
015-1-irogers@google.com?part=3D24

