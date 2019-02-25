From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 11/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 25 Feb 2019 05:31:04 -0800
Message-ID: <20190225133104.GL16922@tassilo.jf.intel.com>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-12-andi@firstfloor.org>
 <20190225125628.GK19795@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225125628.GK19795@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

> for some reason can't see those items in menu

These one needs --samples 10 or similar.

It's off by default currently.

-Andi
