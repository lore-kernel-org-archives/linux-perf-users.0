Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983C5328D1
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791916210; cv=none; b=HD6dmMMppLb8DNwVMjg1cwsFBi7qSpSrnHvao0oYM0fpbMgrOVrVY9kiO1OpCVL/jfqvJGqz/5G6AFbxW0lCT2TCHW/M9fFl6NAWNEVqJLNJyf/MX3REG+R19yFKUf4da0Gh2RwymvIoc2eY5yw+KI/oYJ4IbFmRzLuIeOXgfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791916210; c=relaxed/simple;
	bh=t6zCCzXuC0DIt6BElY008Of4tsfHuiLBf35AAUXLhTM=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=QOLBckXltbflqA+C0D1F8llXUyRr/dwHugDlC4Di5sYr2MLzEtFoIZFJMICjeSqsKBmqadwuQMVu8HpoSE5Jo311eIKX50asmQaShgifvbhAavs3YGDHYTdwHpJ3yc874XwIgKFKGPFYv7I0OXOj2KsMA5G+eTbauGM/5Cxuibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaqFl91B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaqFl91B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D461F000FF;
	Tue, 13 Oct 2026 18:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791916208;
	bh=t6zCCzXuC0DIt6BElY008Of4tsfHuiLBf35AAUXLhTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GaqFl91B+UTRy1Ng3EbR3GxRgtaFXoYlDuxATdsExUhGRR9zG26Dqyz4gjhQXamlD
	 a2NG4lNV05/UvLlj5uaJOqwWiHwLzAwFo+29gyrYf1ByWx8jmD8T+RmiDgJjmfFaP9
	 i5DTy8ciuoxSE/yuyfu1ZXEQCGOYWj3wfZ7FHWIZzei4DjUKVzqrtZm43RtSihEsNV
	 8PycKlW8Lddywg7DXDHwt61VBFV3Vb5Z05ITIEaXfK1Yusvz68ph62JahfjdXVSjdS
	 pyecEw/Zlo/lsIOhBKix1UcBDY3Fv6lY4ZPm0nElTVEO8Ll/KPH97XhjEFG5raXgfG
	 aJAXby8qfMq8A==
Message-ID: <sashiko-outbox-170330@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013182458.1234616-2-irogers@google.com>
References: <20261013182458.1234616-1-irogers@google.com>
 <20261013182458.1234616-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 18:30:08 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> _context_unsafe_alias() does not use its parameter 'p', which triggers
> -Wunused-parameter when building code that enables -Wextra (such as
> tools/perf, tools/lib/perf, tools/lib/subcmd, and tools/lib/symbol).
> Explicitly cast 'p' to void to silence the warning, matching
> __assume_ctx_lock() and __assume_shared_ctx_lock().
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013182458.1234=
616-1-irogers@google.com?part=3D1

