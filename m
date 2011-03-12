From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] Add inverted call graph report support to perf tool
Date: Fri, 11 Mar 2011 17:31:25 -0800
Message-ID: <20110312013125.GA24618@dev1756.snc6.facebook.com>
References: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=vxgHe=dqz+xEPcZ9oBexM1jBxFz3sXA2DJEZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Liao <phyomh@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Mar 07, 2011 at 09:43:27PM +0800, Sam Liao wrote:
> +
> +	/* reverse call chain data */
> +	if (reverse_call && symbol_conf.use_callchain && sample->callchain) {

You probably want to check for nr > 1 here, as in:

 	/* reverse call chain data */
-	if (reverse_call && symbol_conf.use_callchain && sample->callchain) {
+	if (reverse_call && symbol_conf.use_callchain && sample->callchain
+	    && (sample->callchain->nr > 1)) {
 		struct ip_callchain *chain;
 		int i, j;
 		u64 tmp_ip;

Otherwise, if you get a callchain with ->nr == 0, the loop with (nr - 2) will
go on for a long time.

 -Arun
