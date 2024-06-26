Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79995916B;
	Wed, 26 Jun 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719374127; cv=none; b=aJ1YkHKIGO8ADUyQwXAEsWQS3pFLJnG6XksQF9F31HRFPmkNo/GHJ1vLgDytlOpoHHUKRV/JASu2yLfL2dAdkBA1T5ta3vZagfGiERu2z/MgqsLVbObnnhA/xP0rMDaWXrj4JVn00wbQ+SAvjBetJxDWseGdMLLKsvP5mcwDMA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719374127; c=relaxed/simple;
	bh=cZW15rkezFij8vUtEoWV8jBJvT/WhVRdxJxw5hfrtMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ReqLipfiNKSE5bfwWVCFkYtinNVNSEGM2GBdLKluze0qotori8mlWxso190MYHOXRm/EI4Y/qGUsjJ/Eudjvsuebzo4nlAz9OtogwgkdEfFvdUsZ1zE3HkhZpIY3jmohjU//Zolypst0d3mGsI0KMTGZnyykHWyjR2FxoKuI+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLvaWupV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLvaWupV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAA7C2BD10;
	Wed, 26 Jun 2024 03:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719374126;
	bh=cZW15rkezFij8vUtEoWV8jBJvT/WhVRdxJxw5hfrtMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hLvaWupV2+pyLqQ1moqG1DnqXIbAqZZdQshb2jBLYdrwteEqjEDb/KscZWKlA7WFo
	 UreXe96oeTjZH1ZIjklxxj2UHZEVPrpkhW+bZzovAVrS9lh+QzkoQtxf0aH7MWT7Rw
	 D7XXiBtkGx5hWVkZCCnWeHWiaa9DxhF9vyN5coC6bykOGFh6rq9lAIPhPjAws/qVSZ
	 xlNsxmzhPg2wct7GGcRyGPFxzs5m1XOA7ZfxK+n08UV3/8e7JnJdOD1Nk0K9B23aRx
	 DV8RdXMbZ6bM3z4bZvhguwaB77MkFjemUHfj+DGCdntL0cbyBX3+IBd4qDOUmN4OWX
	 /VMQUqqHXWl+Q==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	irogers@google.com,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	akanksha@linux.ibm.com,
	maddy@linux.ibm.com,
	kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH V4 1/3] tools/perf: Fix the string match for "/tmp/perf-$PID.map" files in dso__load
Date: Tue, 25 Jun 2024 20:55:23 -0700
Message-ID: <171937399821.2856850.15411826419678386958.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
In-Reply-To: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
References: <20240623064850.83720-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 23 Jun 2024 12:18:48 +0530, Athira Rajeev wrote:

> Perf test for perf probe of function from different CU fails
> as below:
> 
> 	./perf test -vv "test perf probe of function from different CU"
> 	116: test perf probe of function from different CU:
> 	--- start ---
> 	test child forked, pid 2679
> 	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa7iy89bx/testfile
> 	  Error: Failed to add events.
> 	--- Cleaning up ---
> 	"foo" does not hit any event.
> 	  Error: Failed to delete events.
> 	---- end(-1) ----
> 	116: test perf probe of function from different CU                   : FAILED!
> 
> [...]

Applied the series to perf-tools-next, thanks!

Best regards,
Namhyung
