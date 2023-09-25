Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D230107B8
	for <linux-perf-users@vger.kernel.org>; Mon, 25 Sep 2023 17:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A0FC433C8;
	Mon, 25 Sep 2023 17:10:12 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Tomohiro Misono <misono.tomohiro@fujitsu.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masayoshi Mizuma <msys.mizuma@gmail.com>,
	Stephane Eranian <eranian@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Stephen Boyd <swboyd@chromium.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	ito-yuichi@fujitsu.com,
	gautham.shenoy@amd.com,
	jpoimboe@kernel.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	philmd@linaro.org,
	samitolvanen@google.com,
	scott@os.amperecomputing.com,
	vschneid@redhat.com
Subject: Re: [PATCH v13 0/7] arm64: Add IPI for backtraces / kgdb; try to use NMI for some IPIs
Date: Mon, 25 Sep 2023 18:10:10 +0100
Message-Id: <169566180517.219167.12779213618569283316.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230906160505.2431857-1-dianders@chromium.org>
References: <20230906160505.2431857-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Sep 2023 09:02:55 -0700, Douglas Anderson wrote:
> This is an attempt to resurrect Sumit's old patch series [1] that
> allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> could find was v7, so I started my series at v8. I haven't copied all
> of his old changelongs here, but you can find them from the link.
> 
> This patch series targets v6.6. Specifically it can't land in v6.5
> since it depends on commit 8d539b84f1e3 ("nmi_backtrace: allow
> excluding an arbitrary CPU").
> 
> [...]

Applied to arm64 (for-next/backtrace-ipi), thanks!

[1/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
      https://git.kernel.org/arm64/c/a02026bf9da1
[2/7] arm64: idle: Tag the arm64 idle functions as __cpuidle
      https://git.kernel.org/arm64/c/d0c14a7d36f0
[3/7] arm64: smp: Remove dedicated wakeup IPI
      https://git.kernel.org/arm64/c/2b2d0a7a96ab
[4/7] arm64: smp: Add arch support for backtrace using pseudo-NMI
      https://git.kernel.org/arm64/c/331a1b3a836c
[5/7] arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI
      https://git.kernel.org/arm64/c/d7402513c935
[6/7] arm64: kgdb: Implement kgdb_roundup_cpus() to enable pseudo-NMI roundup
      https://git.kernel.org/arm64/c/2f5cd0c7ffde
[7/7] arm64: smp: Mark IPI globals as __ro_after_init
      https://git.kernel.org/arm64/c/62817d5ba25d

-- 
Catalin

