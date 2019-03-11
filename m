From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH v6 11/11] perf tools ui: Fix ui popup browser for many
 entries
Date: Mon, 11 Mar 2019 15:17:24 -0300
Message-ID: <20190311181724.GU10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-12-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-12-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Em Mon, Mar 11, 2019 at 07:45:02AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Fix the argv ui browser code to correctly display more entries
> than fit on the screen without crashing. The problem was some type
> confusion with pointer types in the ->seek function. Do
> the argv arithmetic correctly with char ** pointers. Also
> add some asserts to find overruns and limit the display function
> correctly.
> 
> Then finally remove a workaround for this in the res sample
> browser.

Applied and added this, please do so next time:

Committer testing:

1) Resize the x terminal to have just some 5 lines

2) Use 'perf report --samples 1' to activate the sample browser options
   in the menu

3) Press ENTER, this will cause the crash:

  # perf report --samples 1
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5a514a]
  /lib64/libc.so.6(+0x385bf)[0x7f27281b55bf]
  /lib64/libc.so.6(+0x161a67)[0x7f27282dea67]
  /lib64/libslang.so.2(SLsmg_write_wrapped_string+0x82)[0x7f272874a0b2]
  perf(ui_browser__argv_refresh+0x77)[0x5939a7]
  perf[0x5924cc]
  perf(ui_browser__run+0x39)[0x593449]
  perf(ui__popup_menu+0x83)[0x5a5263]
  perf[0x59f421]
  perf(perf_evlist__tui_browse_hists+0x3a0)[0x5a3780]
  perf(cmd_report+0x2746)[0x447136]
  perf[0x4a95fe]
  perf(main+0x61c)[0x42dc6c]
  /lib64/libc.so.6(__libc_start_main+0xf2)[0x7f27281a1412]
  perf(_start+0x2d)[0x42de9d]
  #

After applying this patch no crash takes place in such situation.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
