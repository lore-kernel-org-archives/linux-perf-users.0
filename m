Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515F53F20ED
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188094; cv=none; b=KHTPpQGUOkVm2ksg+1qhlQZ1YU+4ObP/qJnc/NvVIKEc0E2+7DDOzk+z+mYEasfWGuqmm66+w0yf/tv9jov4YLIAonPHmDw7yflyvP2H7noZjJ4Z2D/ES3dQeaF3xtN9EtYX/ML7Ip6HkuaKvXMh0oogrRJtwsvw3OvrU/1RwsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188094; c=relaxed/simple;
	bh=7YxUB4lJf7VEPnF3klB/SVuT31LaY64BslpbevWNnPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bruZmPIHIhRMxtkNM8yB5yJOOGjdu/fvS9Z9Dqe/Al0R25HCK1+vYWq8/IJodWziia3fOr2vClV5Z5KipGnAq7OHGzeEGcLdH5A17wR5vcMIcu4WaPSU84awvQovNNvo5bOQjMuf3t+7nUXly5SKvnHrwK/z+svlpNogU7SVL0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZLWJ/iG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZLWJ/iG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69B91F000FF;
	Wed, 23 Sep 2026 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188093;
	bh=E2kfK9g5GtwXEZKDnLzyidmiTpKxQTAmtGX5XM7YuAk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZLWJ/iG/rUgPiNFaYMDJQoBu2vcwzr1Jg+Jksxz2MMB6elZLs0X0ubORngFmf9Ms
	 twiMiLuDeA4lPB0cYJmNSlEt9mrh7b8fO5UTpw/N7OuTgJ8KX9urLFMvXGjwMPB+c1
	 d1BhL0/gGb7DKOV22L8N4iw4WArVYFDHuks+Rnw8hOFyMhmnzqllgkH4BDn6Qqu5u9
	 1WDoXfHi1Zm2QP0vSe/EfFHmcwYX/9nOb2XYg0WgFVqmMAKOzhGUoRXNrUusiSG8r9
	 iWuE3MYZzh4yxXAhS+62MFjJ67xyGZDubZGUaTO+5VYcN2n+9OnUZATcds1vCf1yxh
	 2bMQfaFMEEuCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/49] perf python: Expose addr location,
 transaction, and context_switch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923181213.3032038-9-irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <20260923181213.3032038-1-irogers@google.com>
 <20260923181213.3032038-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 18:28:12 +0000
Message-Id: <20260923182812.E69B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Expose destination address location components (addr_dso, addr_symbol,
> addr_sym_offset), branch/transaction metrics (branch_type, in_tx,
> flags, transaction), machine_pid, vcpu, sym_offset, and context_switch
> callbacks directly to the Python extension.
>=20
> Also include supporting fixes and infrastructure updates in
> util/python.c and perf.pyi:
> - Support fetching sym_offset on resolved sample symbols.
> - Populate sample machine_pid and vcpu from evlist__id2sid() when
>   perf_guest is enabled, and resolve samples against the matching guest
>   or host machine.
> - Expose next_prev_pid and next_prev_tid on switch_event only for
>   PERF_RECORD_SWITCH_CPU_WIDE records (returning None otherwise).
> - Wire up tracing_data in pyrf_session__new() and update perf.pyi type
>   stubs (including srccode() and insn() return types).
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923181213.3032=
038-1-irogers@google.com?part=3D8

