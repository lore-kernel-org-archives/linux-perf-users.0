Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588971;
	b=YoHmHdtSGwFMCY7CU1fKIwGguBCshfXmNGvXLNRUP9RPr3cyhy0TZFxaaYtBBi/yc+2+
	 6QbagVk8obZFWAAuq8yuVP2zHteIVVIPCCzhL24lcYVsX6iywjMdwmtH12Bzhl9BRQV0K
	 imzVNvs9423llr8tWFwpX0TAVwtLSCi3gdSpVtffNE2BflP7HZaEaJbP0IOuj43yTL0CO
	 6ijyllC8e19ZLlpJRxhoRqsTmBh4QkkGLdHRcjNGJQlkk5xsigWNG5gqv3OtS9zZppdrY
	 B29o8mO+gie+1VdfWPMF6X4DalDcjkWXWp6osWGQS7XQKbw93U6zQUut0rIzFZW7pEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588971;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=i9vMOy+uo8ax3stFIP7t1QZaDvCM3hNcpdQXYW35lJk=;
	b=s27WUtsWeqp0nYYtHk1aVv0XISnF4SM7AmNs4SDuH8zsjzMzr9olEiHGuLn8ghezH4q1
	 KnZaHUI0CONAnnF03YDlGv5TgFnM63ovKmfRUh457H/X2FRky2yamckfK9of6t2XdOg5g
	 v35KHnZaL97nAYNKwRXORSdjp+SwenO32k9BXjajxWnxnkugctekNpesOpsG8SlaXlU/z
	 QvrQBL+ybbMFYjhqab6MGNlf5L4CgUQa0jeqRmkuy1objCvd0A9Ne11jvCuiLRHzhjJb4
	 KurfwjfZZUR17iBD92V/3DxWbf/C/FQ7jOTHkaxaA5nkIPfNjNZscKX9jKGVVKwhzwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5TTjAaJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26E606A334
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 16:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X5TTjAaJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BF21F000C4;
	Fri, 13 Nov 2026 16:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588971;
	bh=i9vMOy+uo8ax3stFIP7t1QZaDvCM3hNcpdQXYW35lJk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5TTjAaJJmYUT8+ztvDExCU9jLIehF6x0XlEqDrHuLhj6vtVxnLiDU97TD3E2izPK
	 C907sQ4JMqRZiE9W6CFt0G1PJxPfW65kDu3L3ArXRCoVoAv8FOMIBG7xZCzzAykPTh
	 dU0lOzPer+o8wcKuuglypJUjrgX4gfKqSq0w38aJ1I06cGcsb+L4+b4EogKlPm7+JD
	 iyBbtIAwU/B/q6NwaliRyZP9zia6MhctfH80vg9yC6IeTaxHICs+42fKjyX4cfrcNT
	 FBQLgbSW6e35Af0XUf4IF3C+ZW+o8E4G/6V1eQFFttuxlmBnz38K5dVuaxtBGix97J
	 2jiyPIf69r+tQ==
Message-ID: <sashiko-outbox-213252@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/21] perf build: Enable additional Clang
 thread-safety flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113164152.2095566-6-irogers@google.com>
References: <20261113164152.2095566-1-irogers@google.com>
 <20261113164152.2095566-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:56:10 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Align tools/perf's Clang thread-safety flags with the kernel's
> scripts/Makefile.context-analysis by adding -Wthread-safety-pointer,
> -Wthread-safety-beta, and (when supported by the compiler)
> -fexperimental-late-parse-attributes.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113164152.2095=
566-1-irogers@google.com?part=3D5

