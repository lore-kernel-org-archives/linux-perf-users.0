Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A538F77;
	Tue, 29 Apr 2025 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960866; cv=none; b=TnPFPNAM/QGmFLMq7qHkqzppwn0lgSMJJnl1JtJSsaUVJPgFlCwowpvRPbq/K+yCAcai2u3cLWA2+vMBtmZWor5+nIs9fZbdoNZc+wcqKPZbu+x7mFN14Hwt/MaJgwc0xSjjRTLCnTRqqrfADdzoj0tyUD8359MxWyKjOBoOvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960866; c=relaxed/simple;
	bh=V7rViH5D0tpCYVPtqkUS4FGGwnAdBr2LQpe0ZW5Vqfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuWRkhiJoYr6Vntx3P9LRCgdfYAr2h0/7UDHOiIluMp2T8P+q7hp+Llk4Y2o+V84ghbRYIZZJLg5DRxu9rh2ECbUHp6HMeKHr5Hb7cqBLRY8xvuabC3KQacEsRSqS9RmZAMArsvDrxipxyYbh5JLIMol0e3RWj+bv2sSUsOPYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyEz1ttU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyEz1ttU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D38C4CEEB;
	Tue, 29 Apr 2025 21:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745960866;
	bh=V7rViH5D0tpCYVPtqkUS4FGGwnAdBr2LQpe0ZW5Vqfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyEz1ttUyPPsAddAi63DcvvLHiqVOhKblSCrTX0QBY6R3/Pg3zsnU9LCSacq0Xgwv
	 M8dcAscxXC061qQj4nyu8WT6RmgbXNe0pZgom2+REfNVKSj1ypVDsFlaKA+sJN1skf
	 r2yGeO5Omq0WkTW2WbNNOpJ1lLq9onmlnCq/CEVlFLEMLVnyn/pEYVZ9ZJxwAAOmLE
	 Y7tIZ0xSFhCiXUbS+cKOmDvbamO1PcBK84EeJeEzcIJsRf23ttrKVKhpGbjnnLfzAl
	 JmqMhM2XCsAyuJ1Lw3aXyS8QBgSw0uH7ZeiVZtnxDoVM4N4cEGudi8zuxWPL68aPoR
	 GVYzGXl8MgRGg==
Date: Tue, 29 Apr 2025 18:07:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1 perf-tools-next] perf symbols: Handle 'u' symbols in
 /proc/kallsyms
Message-ID: <aBE_n0PGl3g6h-cS@x1>
References: <aBD15IseHjrB77Uy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBD15IseHjrB77Uy@x1>

On Tue, Apr 29, 2025 at 12:53:12PM -0300, Arnaldo Carvalho de Melo wrote:
> I started seeing this in recent Fedora 42 kernels:
> 
>   # uname -a
>   Linux number 6.14.3-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Apr 20 16:08:39 UTC 2025 x86_64 GNU/Linux
>   #
> 
>   # grep -w u /proc/kallsyms
>   ffffffff99efc7d0 u __pfx__RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   ffffffff99efc7e0 u _RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   #

But in Fedora:40:

root@x1:~# perf test -vv 1 |& grep ERR
ERR : 0xffffffffa0cba810: __pfx__RNCINvNtNtNtCsf6ZhIMomFvR_4core4iter8adapters3map12map_try_foldjNtCs3beuliCOs5m_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_ not on kallsyms
ERR : 0xffffffffa0cba820: _RNCINvNtNtNtCsf6ZhIMomFvR_4core4iter8adapters3map12map_try_foldjNtCs3beuliCOs5m_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_ not on kallsyms
root@x1:~# grep __pfx__RNCINvNtNtNtCsf6ZhIMomFvR_4core4iter8adapters3map12map_try_foldjNtCs3beuliCOs5m_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_ /proc/kallsyms 
ffffffffa0cba810 l __pfx__RNCINvNtNtNtCsf6ZhIMomFvR_4core4iter8adapters3map12map_try_foldjNtCs3beuliCOs5m_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
root@x1:~# uname -r
6.13.9-100.fc40.x86_64
root@x1:~# uname -a
Linux x1 6.13.9-100.fc40.x86_64 #1 SMP PREEMPT_DYNAMIC Sat Mar 29 01:27:18 UTC 2025 x86_64 GNU/Linux
root@x1:~# 
root@x1:~# head /etc/os-release 
NAME="Fedora Linux"
VERSION="40 (Workstation Edition)"
ID=fedora
VERSION_ID=40
VERSION_CODENAME=""
PLATFORM_ID="platform:f40"
PRETTY_NAME="Fedora Linux 40 (Workstation Edition)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:40"
root@x1:~#

It appears in /proc/kallsyms as an 'l' symbol, not 'u'.

So not 'undefined', but 'local', not exported. I'll add 'l' too.

- Arnaldo
 
> The test checks that "vmlinux symtab matches kallsyms", so it finds those two
> symbols in vmlinux:
> 
>   # pahole --running_kernel_vmlinux
>   /usr/lib/debug/lib/modules/6.14.3-300.fc42.x86_64/vmlinux
>   #
> 
>   # readelf -sW /usr/lib/debug/lib/modules/6.14.3-300.fc42.x86_64/vmlinux | grep -Ew '(__pfx__RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_|_RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_)'
>  81844: ffffffff81efc7e0   524 FUNC    LOCAL  DEFAULT    1 _RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> 144259: ffffffff81efc7d0    16 FUNC    LOCAL  DEFAULT    1 __pfx__RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   #
> 
> It is there.
> 
> So lets consider 'u' symbols in /proc/kallsyms when loading it to cover this case.
> 
> With this patch 'perf test 1' is happy again:
> 
>   # perf test vmlinux
>     1: vmlinux symtab matches kallsyms                                 : Ok
>   #
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/symbol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 11540219481ba826..8b3975752553ff37 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -101,7 +101,7 @@ static enum dso_binary_type binary_type_symtab[] = {
>  static bool symbol_type__filter(char symbol_type)
>  {
>  	symbol_type = toupper(symbol_type);
> -	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B';
> +	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B' || symbol_type == 'U';
>  }
>  
>  static int prefix_underscores_count(const char *str)
> -- 
> 2.49.0
> 
