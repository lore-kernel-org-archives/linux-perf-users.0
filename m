From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 06/11] perf tools report: Use less for scripts output
Date: Mon, 25 Feb 2019 13:55:33 +0100
Message-ID: <20190225125533.GD19795@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-7-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190224153722.27020-7-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Sun, Feb 24, 2019 at 07:37:17AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The UI viewer for scripts output has a lot of limitations: limited size,
> no search or save function, slow, and various other issues.
> 
> Just use 'less' to display directly on the terminal instead.
> 
> This won't work in gtk mode, but gtk doesn't support these
> context menus anyways. If that is every done could use an terminal
> for the output.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/ui/browsers/scripts.c | 125 +++++--------------------------
>  1 file changed, 17 insertions(+), 108 deletions(-)

I like the stats ;-)

I assume some of the current includes can be removed as well:

#include <elf.h>
#include <inttypes.h>
#include <sys/ttydefaults.h>
#include <string.h>
#include "../../util/sort.h"
#include "../../util/util.h"
#include "../../util/hist.h"
#include "../../util/debug.h"
#include "../../util/symbol.h"
#include "../browser.h"
#include "../helpline.h"
#include "../libslang.h"

jirka
