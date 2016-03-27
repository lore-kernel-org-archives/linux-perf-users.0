From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the perftool-testsuite
Date: Sun, 27 Mar 2016 14:23:40 +0200
Message-ID: <20160327122340.GG4015@krava.sund.root.ku.dk>
References: <cover.1458134357.git.mpetlan@redhat.com>
 <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44009 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879AbcC0MXo (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 27 Mar 2016 08:23:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Wed, Mar 16, 2016 at 02:50:59PM +0100, Michael Petlan wrote:

SNIP

> +#define TESTSUITE_ROOT "./testsuite/"
> +
> +/* globals */
> +int fatal_occured = 0;
> +char *cwd;
> +
> +
> +/* runs a shell script */
> +int _run_shell(const char *script)
> +{
> +	int ret;
> +	char *cmd = malloc(strlen(script) + 3 * sizeof(char));

please check the return value

jirka
