Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600840;
	b=QIrdFaAsS6qsIPEF09z8clgCfVDtPfESQbKshoU8u/yWENyvgSiuvNdbTJi946iB+SIY
	 iTAHMojqKDsJM3oS3oL0gyYaqWGdIYI1DGBI0s0BVnjh4nWml66zOUtFOwSJsnKVshwRD
	 hvw9128835PWXE5d5RmxjKF1KWJYriESGY45ndTtXs14L/6t/tjFuPBAB9aDA7/Msgz4J
	 M7syc6RbDIHqLqBYT2KxsoFno4z1mzPKDUwVyyHGXZYjgzjf3Etuf44obf8B2gDn23c6d
	 AJDFDTi2LgLyd4af48ehFh7L+zMeuap9uiZdAD7wlQlLBqcELHYCra/MFLafVoJhDtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600840;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j7WvdUyPhHNUgq8KRMQu6kMRqpLRGn+DH1MdfcfsiJc=;
	b=xTaMBKnTYKWrjDflDJIpfBPwgL9L1Gt5W+sVcTC2bF0I+bY507CDbxLJUCQgUURAAzkq
	 F6Rc9r6c5d+vv3N7PCpWfF6RVKPUmtcfhLU289WzmcxDZ73HqaxfCLWIVvmhyioEcLjIw
	 l1Zr9PO1mW4ThAF/C19nKLUwMirq5a0wRVT7NLzW7X8OfY42bz6tja2qzjo2YMX+MJEsj
	 ygLhExNykrIb8dFZidqKm0FN0vk2D6s0FSKnvQdvcFLtIopUzHixN26WQ9JBj3y+uOLvx
	 ubFGaTAUBZJgPzkBQzARXl8Eha+Ts/awrejx4DVwFMxZzj6cvH8cAbecuJjMr6CG/sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P66xDiO/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5FC606A327
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P66xDiO/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE731F000C5;
	Fri, 13 Nov 2026 20:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600840;
	bh=j7WvdUyPhHNUgq8KRMQu6kMRqpLRGn+DH1MdfcfsiJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P66xDiO/NL1Of5wVNdlbcDcA6k5yCpX/OlFjO6jcf+nNZVghmG3PshrPXei0HZI+h
	 JxodZx3yy/xcZYcluM+/izbeaa9wcbyWK93G3csXENEMTq47piSfzbC/+Wp+5T95/h
	 JO3BkjNeu7oy2cUkZbzJWjNlUDHjFGtXEe1IsQElt9MmTT/OG+wXHK+1PToGxNdVN4
	 pNNloQfCzMvrDuJHrh5E7znBnWkve1vwuTHAVQ4hXw1gKbS+CHdo2wnzHNpGLlxYrA
	 T2DrpZqiKcyNUx0ZgAJpeOk/AiS71CSnFPh5met4Lm3cPvgrLluZdjHZvqpakOgb14
	 I9tu9hYrltIpw==
Message-ID: <sashiko-outbox-213628@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 22/30] perf pmu: Add
 perf_pmu__for_each_name_from_config()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-23-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:13:59 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf_pmu__name_from_config() returns the first event alias of a PMU
> whose parsed config matches, ignoring the perf_event_attr type. So a
> legacy hardware event alias can be returned for a raw config of the
> same value, only one of possibly several names is found, and the names
> of legacy events whose aliases were replaced by sysfs or json events of
> the same name can't be found.
>=20
> Add perf_pmu__for_each_name_from_config() that calls a callback for
> each event name of a PMU whose encoding has a given type and config,
> ignoring the extended PMU type of legacy encodings and, for core PMUs,
> also searching the legacy hardware and cache event tables. Make
> perf_pmu__name_from_config() return the first such name for the PMU's
> type.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D22

