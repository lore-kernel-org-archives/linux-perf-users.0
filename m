Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA84443E24;
	Wed, 15 Jul 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140813; cv=none; b=Glz4Hi9jckfLJDI1pMtwAiCLh985KcJ/tiuL6nMdZ38w9v8ju1adoUPhhb3aO1VvzSCdKgdYU+CuN3vX/99epRhR+gJlRsNfx31fVx3FSzkzNFaefiJ+TQ9QxveC9ILZjKTAh5sYkowijwpuAJWqDnPvRvt4YAA8WY90JQPbo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140813; c=relaxed/simple;
	bh=3PgL9WhvAjMY7CNvvahAgGH8zgeEaKombO54Ah11R+8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=m7L42rHOzPORme+6Nk6ugF43C9lA6+I5hpF2Z6NfArkw5j59E2M4DNNcC+fTrAlhO04RtCDuWVfH8qSAD6OlPQjmzxNKyjKPLDCtONKri6wzDNmyF7cah94V6FYl9iNbF0Cn0xs0w7w1i9qClTIK5AZ/OeFA190xzisSTOc8GOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Acl2HE2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Acl2HE2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5561A1F00A3D;
	Wed, 15 Jul 2026 18:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784140798;
	bh=98x4lOPB6iCibeevHkNLZNst//iBXYdG3dCSYqMEQZw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Acl2HE2mhWeTV9iZXmu7i3ldcoyyWj1e1EspSwXoYp/F0TramYaPyzPA1QEAZbLwq
	 +Wr4EXlYh4QKvLXfs5cC9iohLWKuQMIkfMPxLK35UgZ3plKgXOVMOoGV4pytOhcbTc
	 0sgpZx3EYxa7apBXaDTxd0OxstDlKFOF73IPWZxfeRA0sFnPEMYBOCkAJXfAd3lnZY
	 B+Lw+21DM5gdNcNYeS/wmTH+Id5epb28YNcgoGU55fJpkOstxLdgaLwdpBiLT61zPP
	 66chMt83pXhbYi89IlVIEp3+98rzQDZhuuI5kZy5R6tohpx9SrUqdZzzTBDzEousLR
	 VrYFXQr2r+1Qg==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 Hongfu Li <lihongfu@kylinos.cn>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 hongfu.li@linux.dev
In-Reply-To: <20260713093626.492180-1-lihongfu@kylinos.cn>
References: <20260713093626.492180-1-lihongfu@kylinos.cn>
Subject: Re: [PATCH] perf doc: Fix mmap failure checks in topdown example
Message-Id: <178414079831.2318976.8596629427289879759.b4-ty@kernel.org>
Date: Wed, 15 Jul 2026 11:39:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 13 Jul 2026 17:36:26 +0800, Hongfu Li wrote:
> Use MAP_FAILED instead of NULL to detect mmap errors, and fix the
> slots_p variable name typo in the sample code.
> 
> 
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


