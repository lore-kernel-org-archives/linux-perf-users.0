Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB51854;
	Fri, 14 Jun 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371880; cv=none; b=bd1toGjvQKbRHEIn9eZQUa/qbmScKaoIeSrnR1nY1j7c7d8AeaQaohojgO8RBxt1uQHGVHsp6fyEg3aIMTBP0yTzd92rS2X3GaFrVQ/Demy13iJLiVvF7SallPE+5ToLMqXMi8CNAhQCX1B8AGGTkIJumhXCQNOsZRmmpOkswJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371880; c=relaxed/simple;
	bh=XhkHg7eU0fmPQAAgNc8nWOI+aXEfsTCZvQ0c8OcUjGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atgGoTHGLHQxkanW7qlCSO6GZoLJ5eOf76os7E2GRWaj56bVB+P8m4SaNQWcB5Rg8nEpS0LePgxClJo8deyxdYRhpvKMgtcBK0MgasH3pSXGkDhuHpWX2739IzQuRhV1S8ZEN0VZDKhSGwBqYQN9P1OPPXus4n8SimKh4ssgT+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbh9QE+b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbh9QE+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511E6C2BD10;
	Fri, 14 Jun 2024 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718371879;
	bh=XhkHg7eU0fmPQAAgNc8nWOI+aXEfsTCZvQ0c8OcUjGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbh9QE+bN55WIEOEv8V1EivkDvHZBYwy6N9155V93U3nz2MbMb5Dlq3O4MpETQE0D
	 qUsKMkVfsiNJZuhrWTcP1qKjvbKL3og3sQsujO8l+xQKW03+HSUbHZC7FnhzoW5etj
	 +Qkc3iecTcJMMBfeBQy4/9aDoWRBdrSQXh/9X79cj04yXw09jPyy/mmlTikVZd3dWI
	 a/OdMte/DuhU04/4le9B4yT1ZD8DlkkMOFS5OwcfthS6W+PrL6fivi66npqysp/hiE
	 bLNS7ADPMNxHUB3S+WZ6MVr6vSXCT7krtp3kRGWAhQ0rsagwZKCl5DEXEBQnlEqCAk
	 qI3l4G1e2xiwQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v2] perf record: Ensure space for lost samples
Date: Fri, 14 Jun 2024 06:31:16 -0700
Message-ID: <171837125174.3039059.16928717312076037768.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240611050626.1223155-1-irogers@google.com>
References: <20240611050626.1223155-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 10 Jun 2024 22:06:26 -0700, Ian Rogers wrote:

> Previous allocation didn't account for sample ID written after the
> lost samples event. Switch from malloc/free to a stack allocation.
> 
> 

Applied to perf-tools-next, thanks!

Arnaldo, I'll resolve the conflict when I merge perf-tools later which
has the revert.

Best regards,
Namhyung
