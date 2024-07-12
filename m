Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC9B176226;
	Fri, 12 Jul 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802775; cv=none; b=NWsUzBNK2RDqYCGOe0QuvWGDItCO7ox/I18n59OR9VDrEfgEJskklzvN1qMmbcswqp+W5v7LvC7543lEHnjBcGFVTyFPoRbP+TgMHvJ1gufEcRG41DgglpetNS5Lg5glc0uOubWPFboxV1MSlGSeyaeigfbV/lqcEA3CyE0ZoXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802775; c=relaxed/simple;
	bh=09Z5+4sTDO3QqJqVkd/f4uI8lwcTUbf1aPd7WVTQjk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaX0GEsOCQrQnwf7bxqNKBeqWrukqIUz3qyM4T3CnUHAev0clcnY3Xds44RhjsWv1+aRq3ALtqgYmkqaiPtyBb+PUIQwnEedPxjKzDzrYp11kfyVB/3JlfKSqwClaUxF+hbsmI3qWl/S5JdocVEKUos4btCTJ4btyDKCSY7vWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihhf+5np; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihhf+5np"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CA9C32782;
	Fri, 12 Jul 2024 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720802774;
	bh=09Z5+4sTDO3QqJqVkd/f4uI8lwcTUbf1aPd7WVTQjk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ihhf+5npjh4OFdxTfHi8gH32pNoivoe0808xkQbPW+dYPMIYvDd4zFuC6Qa36HBXl
	 Bs+f/sIC/oMIzSd1v+P+xpBi7zPOGxTGdWus/m46U96lRi3li3ij/uRipQYWzykujx
	 5sE257YqW05cdkmwa8SKCTjjeJsVt1JDYMlVaPSg+fsC6WqqCOdHp4s8YTwkL9lwEO
	 YzFfPwcHG8UC2UQLKOY0cpc5tdBwkBhRWDoBP9zKAKdLWUeFd7XSX5hvG/i72HcqQG
	 sdWI7fC3QCKszChOnrBw8PSdzz4p0rksy0FZ4b6QEVOd3+BTbHVX0djeGuPmOPxB0C
	 1+5nGZNKipzTA==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	Haoze Xie <royenheart@gmail.com>
Cc: mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuan Tan <tanyuan@tinylab.org>
Subject: Re: [PATCH 1/1] perf build x86: Fix SC2034 error in syscalltbl.sh
Date: Fri, 12 Jul 2024 09:46:12 -0700
Message-ID: <172080275765.2773745.9913897483035767559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
In-Reply-To: <2143cab4cd8468c88860f4e5e382d0e6b4d89ac9.1720372178.git.royenheart@gmail.com>
References: <cover.1720372178.git.royenheart@gmail.com> <2143cab4cd8468c88860f4e5e382d0e6b4d89ac9.1720372178.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 08 Jul 2024 02:04:02 +0800, Haoze Xie wrote:

> Change the unused var in 'arch/x86/entry/syscalls/syscalltbl.sh' to '_'
> when reading from '$sorted_table'. This change allows the script to pass
> tests of ShellCheck before and after version 0.7.2 at the same time.
> 
> When building in arch x86, syscalltbl.sh got a ShellCheck warning, which
> makes compilation error:
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
