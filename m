From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v5 01/15] perf tools: Add utility function to fetch
 executable
Date: Mon, 11 Mar 2019 13:32:40 +0100
Message-ID: <20190311123240.GC26829@krava>
References: <20190309055628.21617-1-andi@firstfloor.org>
 <20190309055628.21617-2-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190309055628.21617-2-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 08, 2019 at 09:56:14PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a utility function to fetch executable code. Convert one
> user over to it. There are more places doing that, but they
> do significantly different actions, so they are not
> easy to fit into a single library function.

fyi, Arnaldo added thread__memcpy based on your patch:

153259382633 perf thread: Generalize function to copy from thread addr space from intel-bts code

jirka
