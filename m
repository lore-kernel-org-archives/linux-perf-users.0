Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B623E342;
	Fri,  9 May 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746821029; cv=none; b=tp7aUPiVuo1gFKyInyVnUdSx1akLY0n5iXCbNSv1GNn77eA9/wcgLVc1LvaasCOcQDm2Cu0bRaOTC8qYwsBxlE4hL6rWA6RM7XvsHuIgIzbxMjk8KF8x1UpM9hYDm6QsRCSyfaMKDYsg8ZgHiw9sIY1ulH5ZPiPGbGiljTEX5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746821029; c=relaxed/simple;
	bh=Tlb5MDgotIsmFC5l0enuv4HrkZGo1UYHZBpeu4qlZeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+T4McVwDcQZl0CdrDP0WRJKYKWcuxVomZrqYSkZEe+hUUZ9QCrFaBGrvCUn+QzCCJ4hgMfRyq3pHInKx/x3F4mSAmw6X8Y/8VoTuQuXsf6BOOknkqttFAnpV3IG3ivC9+lD4Q6vhVZdYPVTHhcmy6a6MUeZYaBoBUvl8ITZXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvGlyerw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvGlyerw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C93EC4CEE4;
	Fri,  9 May 2025 20:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746821028;
	bh=Tlb5MDgotIsmFC5l0enuv4HrkZGo1UYHZBpeu4qlZeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvGlyerwXRkpmzHnBUeKJCpK7IgRxYieKDXWZmfUv9CHHNUsCb3nkvKF/XJDfrQWF
	 3wgyQenDD0gaD/MlO4dJQsuhnPfIpkktj/eIJJI2iJHaRj9yX4HxjJnFRgjp01Qc9X
	 yGP70dk5ivyzPzXzv4//Q4p/psZm/EjidykT8dC+Ib/EwPVYuxdqZmQyEfNMXYQ7Y2
	 zxIqeW5PzHb7mTFRNUJXk6wqM6MB3B+ncevEScmIOSkcM6LH1ntjkbFw3+v4r1myTL
	 ybqP1/yuWmHJ/XlorLsIJ36Jw7TNYOR9NOxAlnYJDJxtOdmkCFU2AR58L3Gchw9LeC
	 DmwGIhDobDmtg==
Date: Fri, 9 May 2025 17:03:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
	Daniel Xu <dxu@dxuuu.xyz>, Ariel Ben-Yehuda <ariel.byd@gmail.com>
Subject: Re: [PATCH v2 0/6] Use rustc-demangle for Rust demangling
Message-ID: <aB5fog7c-Ucs6dAN@x1>
References: <20250430004128.474388-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250430004128.474388-1-irogers@google.com>

On Tue, Apr 29, 2025 at 05:41:22PM -0700, Ian Rogers wrote:
> Discussion of improved Rust demangling started with:
> https://lore.kernel.org/lkml/jgxfnphfo3nzlfipnuuzdlfc4ehbr2tnh2evz3mdhynd6wvrsu@fcz6vrvepybb/
> that led to implementing a Rust v0 demangler:
> https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
> Discussion on that patch series led to the rust-lang issue:
> https://github.com/rust-lang/rust/issues/60705
> where the pre-existing Rust C demangler, authored by Ariel Ben-Yehuda
>  <ariel.byd@gmail.com>, was mentioned. There wasn't progress on that
> issue and so I've pulled that work into perf as discussed on the
> issue.
> 
> v2: Changes to references from arielb1 to "Ariel Ben Yehuda
>     <ariel.byd@gmail.com>", license tidying as suggested by Miguel
>     Ojeda" <ojeda@kernel.org>. Don't change from alternate demangling
>     flag from false to true in the test change, make it true from the
>     beginning (patch 2).
> 
> Ian Rogers (6):
>   perf demangle-rust: Add rustc-demangle C demangler
>   perf symbol-elf: Integrate rust-v0 demangling
>   perf demangle-rust: Remove previous legacy rust decoder
>   perf test demangle-rust: Add Rust demangling test
>   perf test demangle-java: Switch to using dso__demangle_sym
>   perf test demangle-ocaml: Switch to using dso__demangle_sym

I'm fixing these up, ok?

  ✗ BADSIG: DKIM/google.com
---
Total patches: 6
---
Cover: ./v2_20250429_irogers_use_rustc_demangle_for_rust_demangling.cover
 Link: https://lore.kernel.org/r/20250430004128.474388-1-irogers@google.com
 Base: applies clean to current tree
       git checkout -b v2_20250429_irogers_google_com HEAD
       git am ./v2_20250429_irogers_use_rustc_demangle_for_rust_demangling.mbx
⬢ [acme@toolbx perf-tools-next]$        git am ./v2_20250429_irogers_use_rustc_demangle_for_rust_demangling.mbx
Applying: perf demangle-rust: Add rustc-demangle C demangler
.git/rebase-apply/patch:1098: trailing whitespace.
    
.git/rebase-apply/patch:1363: trailing whitespace.
    
.git/rebase-apply/patch:1474: trailing whitespace.
    default: 
.git/rebase-apply/patch:1791: trailing whitespace.
        { NULL }, 
.git/rebase-apply/patch:1814: trailing whitespace.
        // From here on, inner contains a pointer to the next element, rest[:len] to the current one        
warning: squelched 4 whitespace errors
warning: 9 lines add whitespace errors.
Applying: perf symbol-elf: Integrate rust-v0 demangling
Applying: perf demangle-rust: Remove previous legacy rust decoder
Applying: perf test demangle-rust: Add Rust demangling test
Applying: perf test demangle-java: Switch to using dso__demangle_sym
Applying: perf test demangle-ocaml: Switch to using dso__demangle_sym
⬢ [acme@toolbx perf-tools-next]$

Applied.

- Arnaldo
