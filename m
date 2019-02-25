From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 25 Feb 2019 14:35:46 +0100
Message-ID: <20190225133546.GB14757@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
 <20190225125628.GK19795@krava>
 <20190225133104.GL16922@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225133104.GL16922@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 25, 2019 at 05:31:04AM -0800, Andi Kleen wrote:
> > for some reason can't see those items in menu
> 
> These one needs --samples 10 or similar.
> 
> It's off by default currently.

I did, must be those hacks I put in to compile it,
will check in new version

jirka
