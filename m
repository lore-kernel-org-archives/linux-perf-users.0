Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE281CAA9C;
	Tue, 25 Mar 2025 19:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932171; cv=none; b=UWBQ09dXEgEP9J2V7phlNvxIMFaBCmIdIrYxL2uOSTDHHyIOfxL4Mgg6ByuwwxYuEzX2eOGWjaIDv7pEjPaC5FRivkW/0qKp7q/7rYNRyFjQojjpLWH1qHodxw7YThOtcA10+CKxQ1aBx23rwh1VAkY8iGNX6T+S6jw+IkPebMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932171; c=relaxed/simple;
	bh=DRm0EkerExRykpm5wpugNLtM8zMU1rfzYGU0GP0aR/E=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eAXx9m/relfE2sDfZlu5lnNpkhU2RK/1///8hzeQ6ajoCdeTt/aAYSKYs/lbrZOWufh8y1/nhGPBwN9UFD8p7TRtju0n9MI8FE9EV9AjDlGEFbPpIP+dc0sMDsKV5aABJenTQtHAv3nP2lj1fHcrT1Ct69G5oYoUZtLK29MOenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDe9KNsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDe9KNsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41FD4C4CEE4;
	Tue, 25 Mar 2025 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742932170;
	bh=DRm0EkerExRykpm5wpugNLtM8zMU1rfzYGU0GP0aR/E=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=VDe9KNsVqB7v2LJgIxo2McN2818oIswqotBjXIEK2+g1hnRczAEmSVwbSGg45OAYm
	 KKfzFpztAop2A14VSnE2mHFJKb8RxAx9OyMEQvq7xEVF7VZWJWmMXSNuUhxcAnJYWy
	 +0uokfJrkkSxCaOPzgwOw+van+kJb+2QnQYzLZOKXOsvc6RoSKtgkhGJCbh205BV+b
	 10O/fLwwGAOh2I628qCATXD8ITkNQ1cJwHKpo/fA4lP7ayb3IwpsfWo7mpbWA8VEyH
	 LJ4g9Eg8h0gH6TPMjUyvgWY9WpzxGJkEC+eq04C/QsmkRupCogKMpXzyoSLAmDwDyK
	 ZCXsTJL9sEr1w==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 John Garry <john.g.garry@oracle.com>, 
 Veronika Molnarova <vmolnaro@redhat.com>, 
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20250311213628.569562-1-irogers@google.com>
References: <20250311213628.569562-1-irogers@google.com>
Subject: Re: [PATCH v2 0/6] Mypy and pylint build support
Message-Id: <174293217022.2401011.8796025370875674731.b4-ty@kernel.org>
Date: Tue, 25 Mar 2025 12:49:30 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 11 Mar 2025 14:36:22 -0700, Ian Rogers wrote:
> Support building perf checking the python code with mypy and/or
> pylint. Currently there are too many errors to make this a default.
> 
> Shellcheck generates no output on success, so linking shellcheck files
> doesn't cause `ld` to fail. Mypy and pylint generate output that will
> break `ld` so change the Makefile.build to ignore test log files.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


