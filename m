Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B254513A276;
	Thu, 27 Jun 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512434; cv=none; b=VKLoqW8EEA9wVpy0WauZYcdDCICAbV0Iij1F3y6ulnTRUOhGaFTHuc1kzh5fdKrmNH9qVhmi9OAPNMtNEo9lJr5/OX/6AptG7BLwo6gMMt2PDhz9p7kz5GDXQOgvOwDVhMu98nAvlsUDLDWXSqxKwFlV2xZh1uCRnnbj6+WSNrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512434; c=relaxed/simple;
	bh=ImO7nqNkX62aoEXY5o0kjRa1kqA0yhh4nelvbAn/Hs4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWXP0z6IEUTZAmgnbZH2c1w0VfQ70LdeGLJqe5mRI5DrLjHumS+kSXSiYK8Gfws+bNcW7moPo6kHdl8RygJBeADykv4YTZJ+dHT58HcUMZ87AMmhfxvIdnXU80y9bNrRyjotTmOHTBNkPfcyzkYw2PRr8ELXLeawBYkJ/kQTN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPJ7OtE2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPJ7OtE2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A9EC2BBFC;
	Thu, 27 Jun 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719512434;
	bh=ImO7nqNkX62aoEXY5o0kjRa1kqA0yhh4nelvbAn/Hs4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=vPJ7OtE2Z3UJXOVMel7bQY73mLBmaQhgz9yaAwxZxOHzdDjdL0XHsmyMWBNuQIfPV
	 BYDB+IkzOwZEdXGfN080JLfgq0ETlpQ07bLUaPVWtwRkyF8SZ2AfaQPCU4qr8SC8j5
	 b8mb8pI2acm53Fw4xJQY2GSKquq/MLDyjXt46HauFMsgS9++9e1h58MRC/CN0A4egp
	 IyYOs8fKvHk+rYjG3dF076PMrZ84PCh5QP13Lsoxv7+fiH9E2jdjXQNFlNtjFLcw8d
	 0EjW7AsRajVrSWVlhDQNeZkEMCCziEZ70QxTh3KjLD5RW0Ii1ND7/cRnMhp4q7w7vP
	 t+WeyL0v07FLg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Nick Terrell <terrelln@fb.com>,
	Andrei Vagin <avagin@google.com>,
	Kees Cook <keescook@chromium.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Ze Gao <zegao2021@gmail.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v5 0/8] Refactor perf python module build
Date: Thu, 27 Jun 2024 11:20:29 -0700
Message-ID: <171951241289.5789.4704334640425838387.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240625214117.953777-1-irogers@google.com>
References: <20240625214117.953777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 25 Jun 2024 14:41:09 -0700, Ian Rogers wrote:

> Refactor the perf python module build to instead of building C files
> it links libraries. To support this make static libraries for tests,
> ui, util and pmu-events. Doing this allows fewer functions to be
> stubbed out, importantly parse_events is no longer stubbed out which
> will improve the ability to work with heterogeneous cores.
> 
> By not building .c files for the python module and for the build of
> perf, this should also help build times.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
