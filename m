Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4C1D89FC
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Oct 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070154; cv=none; b=nr9C7JhizYHtvjm+8A9S3v9p1qkyRaCW3+uWCiofnIW9bFcmKwJ5kTkTLMO4jD+eDticWdJr06n/OuzPaVwoZJt0bu0uW+oMeBSG8OecAoqsujjTbGE0wH4Ov9h4E3yMHyFE+i6HIZvgJI39U5lnJB6Vd5HS8tjQrDRMctjC0W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070154; c=relaxed/simple;
	bh=AJGmvRmbOo9BitssiIVa/eJcmpkII1Qh680KJKFw8cY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HIxNgjYRJmmPuv+wuwv7smAWISlJ+Z5Uz1CTs6USx0pUs/Bc7WqoD6IRcBGa2F5/3Brmdpiiy4uEBLuIk2rQGy1Vm5Q5iye9ZvlSnaBRjd+brTKVFr/IshEQbqx87WvuBSEMFnKPG9T/Omv6LfwUChh5BQQJAER5PcIllznjhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq4TWwOv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq4TWwOv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B6DC4CECE;
	Fri,  4 Oct 2024 19:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070154;
	bh=AJGmvRmbOo9BitssiIVa/eJcmpkII1Qh680KJKFw8cY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Yq4TWwOvyFtwHdyxxbQ0EGx47ku88RRN36Yzp3m+o09NrshOHPAKYkK5re48PAus/
	 Fpd25j20H6Yvpr3FRbqoGjjsPJ8QA5K8GRc9Pxw1vcwse67M6xV+22XRTO9XYQa+LG
	 77CtCBVnVTY/p4goDuSo95nwKG+PBOgNMLRHU7aM4Wzf2TygwRSvhzrUkg8FIoBJ3C
	 uTm6I1Ajc73baO1fefmy3ckIbEkxvmRhuYGI0+Zw36A2X5a020fJsF4dz71cSlhA1u
	 bAC4Emz0piY+bl91xOZBT4ThKsyCvMJpGFuBzfOQ88DyzQjd/wbpApSxciBRGJhFJ3
	 g5XWDnXSd0r4w==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com, 
 vmolnaro@redhat.com
Cc: mpetlan@redhat.com, adrian.hunter@intel.com, 
 alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
 kan.liang@linux.intel.com, mark.rutland@arm.com
In-Reply-To: <20241003125136.15918-1-vmolnaro@redhat.com>
References: <ZvyRefEz4lj4evm5@google.com>
 <20241003125136.15918-1-vmolnaro@redhat.com>
Subject: Re: [PATCH v2] perf test: Restore sample rate for perf_event_attr
Message-Id: <172807015402.55364.12529583038234440690.b4-ty@kernel.org>
Date: Fri, 04 Oct 2024 12:29:14 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-d4707

On Thu, 03 Oct 2024 14:51:36 +0200, vmolnaro@redhat.com wrote:

> Test "Setup struct perf_event_attr" consists of multiple test cases that
> can affect the max sample rate value for perf events. Some test cases
> check this value as it should not be lowered under the set minimum for
> the given test. Currently, it is possible for the test cases to affect
> each other as the previous tests can lower the sample rate, leading to
> a possible failure of some of the future test cases as the value is not
> restored at any point.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

